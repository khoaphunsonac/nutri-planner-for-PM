<?php

namespace App\Support;

use Illuminate\Database\Eloquent\Builder;

class AppliesKeywordOrIdSearch
{
    public static function apply(Builder $query, string $textColumn, mixed $search): Builder
    {
        if (blank($search)) {
            return $query;
        }

        return $query->where(function (Builder $query) use ($textColumn, $search) {
            $query->where($textColumn, 'like', "%{$search}%");

            if (ctype_digit((string) $search)) {
                $query->orWhere('id', (int) $search);
            }
        });
    }
}
