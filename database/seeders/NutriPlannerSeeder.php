<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class NutriPlannerSeeder extends Seeder
{
    /**
     * Seed the application's database with data from the legacy SQL dump.
     */
    public function run(): void
    {
        $sqlFile = database_path('seeders/sql/nutriplanner_data.sql');

        if (!file_exists($sqlFile)) {
            $this->command->error("SQL seed file not found: {$sqlFile}");
            return;
        }

        $this->command->info('Importing NutriPlanner data from SQL file...');

        $sql = file_get_contents($sqlFile);
        $driver = DB::getDriverName();

        $orderedTables = [
            'accounts',
            'allergens',
            'contacts',
            'diet_type',
            'meal_type',
            'tags',
            'ingredients',
            'meals',
            'feedback',
            'password_reset_tokens',
            'meal_allergens',
            'meals_tags',
            'recipe_ingredients',
            'user_allergens',
        ];

        $statements = array_filter(
            array_map('trim', preg_split('/;\s*\n/', $sql)),
            fn ($statement) => !empty($statement) && str_starts_with(strtoupper($statement), 'INSERT INTO')
        );

        usort($statements, function (string $left, string $right) use ($orderedTables): int {
            return $this->getTablePriority($left, $orderedTables) <=> $this->getTablePriority($right, $orderedTables);
        });

        $count = 0;
        foreach ($statements as $statement) {
            $normalizedStatement = $this->normalizeInsertStatement($statement, $driver);

            try {
                DB::unprepared($normalizedStatement . ';');
                $count++;
            } catch (\Throwable $exception) {
                $this->command->warn(
                    "Skipped statement: " . substr($normalizedStatement, 0, 80) . "... Error: " . $exception->getMessage()
                );
            }
        }

        if ($driver === 'pgsql') {
            $this->syncPostgresSequences();
        }

        $this->command->info("Successfully imported {$count} statements.");
    }

    private function normalizeInsertStatement(string $statement, string $driver): string
    {
        if ($driver === 'pgsql') {
            $statement = str_replace('`', '"', $statement);
            $statement = preg_replace("/\\\\'/", "''", $statement);
            $statement = preg_replace('/\\\\\"/', '"', $statement);

            return $statement;
        }

        return $statement;
    }

    private function getTablePriority(string $statement, array $orderedTables): int
    {
        if (!preg_match('/INSERT INTO [`"]?([a-zA-Z0-9_]+)[`"]?/i', $statement, $matches)) {
            return count($orderedTables) + 1;
        }

        $tableName = strtolower($matches[1]);
        $position = array_search($tableName, $orderedTables, true);

        return $position === false ? count($orderedTables) + 1 : $position;
    }

    private function syncPostgresSequences(): void
    {
        $tables = DB::select("
            SELECT table_name
            FROM information_schema.columns
            WHERE table_schema = 'public'
              AND column_name = 'id'
            GROUP BY table_name
        ");

        foreach ($tables as $table) {
            $tableName = $table->table_name;
            $sequenceName = DB::scalar(
                "SELECT pg_get_serial_sequence(?, 'id')",
                ["public.{$tableName}"]
            );

            if (!$sequenceName) {
                continue;
            }

            $maxId = (int) (DB::table($tableName)->max('id') ?? 0);
            $nextValue = max($maxId, 1);
            $isCalled = $maxId > 0;

            DB::statement(
                "SELECT setval(?, ?, ?)",
                [$sequenceName, $nextValue, $isCalled]
            );
        }
    }
}
