<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class NutriPlannerSeeder extends Seeder
{
    /**
     * Seed the application's database with data from SQL dump.
     */
    public function run(): void
    {
        $sqlFile = database_path('seeders/sql/nutriplanner_data.sql');

        if (!file_exists($sqlFile)) {
            $this->command->error("SQL seed file not found: {$sqlFile}");
            return;
        }

        $this->command->info('Importing NutriPlanner data from SQL file...');

        // Disable FK checks during import
        DB::statement('SET FOREIGN_KEY_CHECKS = 0');

        $sql = file_get_contents($sqlFile);

        // Split by semicolons that end a statement (not inside quotes)
        $statements = array_filter(
            array_map('trim', preg_split('/;\s*\n/', $sql)),
            fn($s) => !empty($s) && stripos($s, 'INSERT') !== false
        );

        $count = 0;
        foreach ($statements as $statement) {
            try {
                DB::unprepared($statement . ';');
                $count++;
            } catch (\Exception $e) {
                $this->command->warn("Skipped statement: " . substr($statement, 0, 80) . "... Error: " . $e->getMessage());
            }
        }

        // Re-enable FK checks
        DB::statement('SET FOREIGN_KEY_CHECKS = 1');

        $this->command->info("Successfully imported {$count} statements.");
    }
}
