<?php

namespace Tests\Feature;

use App\Models\IngredientModel;
use App\Support\AppliesKeywordOrIdSearch;
use Tests\TestCase;

class AdminSearchQueryTest extends TestCase
{
    public function test_non_numeric_keyword_only_binds_like_clause(): void
    {
        $query = IngredientModel::query();

        AppliesKeywordOrIdSearch::apply($query, 'name', 'Hanh');

        $this->assertStringContainsString('"name"::text like ?', $query->toSql());
        $this->assertStringNotContainsString('or "id" = ?', $query->toSql());
        $this->assertSame(['%Hanh%'], $query->getBindings());
    }

    public function test_numeric_keyword_binds_like_and_id_clause(): void
    {
        $query = IngredientModel::query();

        AppliesKeywordOrIdSearch::apply($query, 'name', '12');

        $this->assertStringContainsString('"name"::text like ?', $query->toSql());
        $this->assertStringContainsString('or "id" = ?', $query->toSql());
        $this->assertSame(['%12%', 12], $query->getBindings());
    }
}
