<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class NutriPlannerSupplementSeeder extends Seeder
{
    public function run(): void
    {
        foreach ($this->ingredientCatalog() as $ingredient) {
            $this->ensureIngredient($ingredient);
        }

        foreach ($this->mealCatalog() as $meal) {
            $dietTypeId = $this->ensureNamedRecord('diet_type', $meal['diet_type']);
            $mealTypeId = $this->ensureNamedRecord('meal_type', $meal['meal_type']);

            $mealId = $this->ensureMeal($meal, $dietTypeId, $mealTypeId);

            foreach ($meal['tags'] as $tagName) {
                $tagId = $this->ensureNamedRecord('tags', $tagName);
                $this->ensurePivot('meals_tags', [
                    'meal_id' => $mealId,
                    'tag_id' => $tagId,
                ]);
            }

            foreach ($meal['allergens'] as $allergen) {
                $allergenId = $this->ensureNamedRecord('allergens', $allergen['name'], $allergen['aliases'] ?? []);
                $this->ensurePivot('meal_allergens', [
                    'meal_id' => $mealId,
                    'allergen_id' => $allergenId,
                ]);
            }

            foreach ($meal['ingredients'] as $recipeIngredient) {
                $ingredientId = $this->ensureIngredient($recipeIngredient['ingredient']);
                $quantity = $recipeIngredient['quantity'];
                $totalCalo = round(($recipeIngredient['kcal_per_100g'] * $quantity) / 100, 2);

                $exists = DB::table('recipe_ingredients')
                    ->where('meal_id', $mealId)
                    ->where('ingredient_id', $ingredientId)
                    ->exists();

                if ($exists) {
                    continue;
                }

                DB::table('recipe_ingredients')->insert([
                    'meal_id' => $mealId,
                    'ingredient_id' => $ingredientId,
                    'quantity' => $quantity,
                    'total_calo' => $totalCalo,
                    'created_at' => now(),
                    'updated_at' => now(),
                    'deleted_at' => null,
                ]);
            }
        }
    }

    private function ingredientCatalog(): array
    {
        return [
            ['name' => 'Ức gà', 'aliases' => ['Ức gà chín'], 'unit' => 'gram', 'protein' => 31, 'carb' => 0, 'fat' => 3.6],
            ['name' => 'Thịt bò', 'aliases' => ['Thăn bò', 'Thịt bò thăn'], 'unit' => 'gram', 'protein' => 26, 'carb' => 0, 'fat' => 15],
            ['name' => 'Ba chỉ heo', 'aliases' => ['Thịt ba chỉ lợn', 'Ba chỉ'], 'unit' => 'gram', 'protein' => 9, 'carb' => 0, 'fat' => 53],
            ['name' => 'Cá hồi', 'aliases' => ['Cá hồi phi lê'], 'unit' => 'gram', 'protein' => 20, 'carb' => 0, 'fat' => 13],
            ['name' => 'Cá ngừ', 'aliases' => ['Cá ngừ phi lê'], 'unit' => 'gram', 'protein' => 28, 'carb' => 0, 'fat' => 1],
            ['name' => 'Tôm', 'aliases' => ['Tôm tươi'], 'unit' => 'gram', 'protein' => 24, 'carb' => 0.2, 'fat' => 0.3],
            ['name' => 'Trứng', 'aliases' => ['Trứng gà'], 'unit' => 'gram', 'protein' => 13, 'carb' => 1.1, 'fat' => 11],
            ['name' => 'Lươn đồng', 'aliases' => ['Lươn'], 'unit' => 'gram', 'protein' => 18.7, 'carb' => 0, 'fat' => 25],
            ['name' => 'Yến mạch', 'aliases' => [], 'unit' => 'gram', 'protein' => 16.9, 'carb' => 66, 'fat' => 6.9],
            ['name' => 'Cơm trắng', 'aliases' => ['Gạo', 'Cơm nguội', 'Gạo/Cơm trắng'], 'unit' => 'gram', 'protein' => 2.4, 'carb' => 28, 'fat' => 0.3],
            ['name' => 'Đậu hũ', 'aliases' => ['Đậu phụ', 'Đậu phụ trắng'], 'unit' => 'gram', 'protein' => 8, 'carb' => 1.9, 'fat' => 4.8],
            ['name' => 'Hạt chia', 'aliases' => [], 'unit' => 'gram', 'protein' => 16.5, 'carb' => 42, 'fat' => 30.7],
            ['name' => 'Sữa chua không đường', 'aliases' => [], 'unit' => 'gram', 'protein' => 5, 'carb' => 5, 'fat' => 1.5],
            ['name' => 'Bánh mì', 'aliases' => ['Bánh mì Baguette'], 'unit' => 'gram', 'protein' => 10, 'carb' => 52, 'fat' => 1.2],
            ['name' => 'Bông cải xanh', 'aliases' => [], 'unit' => 'gram', 'protein' => 2.8, 'carb' => 6.6, 'fat' => 0.4],
            ['name' => 'Rau chân vịt', 'aliases' => ['Cải bó xôi'], 'unit' => 'gram', 'protein' => 2.9, 'carb' => 3.6, 'fat' => 0.4],
            ['name' => 'Bí đỏ', 'aliases' => [], 'unit' => 'gram', 'protein' => 1, 'carb' => 6.5, 'fat' => 0.1],
            ['name' => 'Cà chua', 'aliases' => ['Cà chua bi'], 'unit' => 'gram', 'protein' => 0.9, 'carb' => 3.9, 'fat' => 0.2],
            ['name' => 'Bơ', 'aliases' => ['Bơ quả'], 'unit' => 'gram', 'protein' => 2, 'carb' => 9, 'fat' => 15],
            ['name' => 'Chuối', 'aliases' => [], 'unit' => 'gram', 'protein' => 1.1, 'carb' => 22.8, 'fat' => 0.3],
            ['name' => 'Dứa', 'aliases' => [], 'unit' => 'gram', 'protein' => 0.5, 'carb' => 13.1, 'fat' => 0.1],
            ['name' => 'Hành tím', 'aliases' => [], 'unit' => 'gram', 'protein' => 1.1, 'carb' => 8.2, 'fat' => 0.1],
            ['name' => 'Ớt', 'aliases' => [], 'unit' => 'gram', 'protein' => 2, 'carb' => 9, 'fat' => 0.2],
            ['name' => 'Nước dừa', 'aliases' => [], 'unit' => 'ml', 'protein' => 0.7, 'carb' => 3.7, 'fat' => 0.2],
            ['name' => 'Dầu olive', 'aliases' => ['Dầu oliu'], 'unit' => 'gram', 'protein' => 0, 'carb' => 0, 'fat' => 100],
            ['name' => 'Chanh', 'aliases' => [], 'unit' => 'gram', 'protein' => 0.4, 'carb' => 9.3, 'fat' => 0.1],
            ['name' => 'Whipping cream', 'aliases' => ['Kem tươi'], 'unit' => 'ml', 'protein' => 2, 'carb' => 3, 'fat' => 36],
            ['name' => 'Nước dùng gà', 'aliases' => [], 'unit' => 'ml', 'protein' => 2.5, 'carb' => 0.5, 'fat' => 1.5],
            ['name' => 'Hành tây', 'aliases' => [], 'unit' => 'gram', 'protein' => 1.1, 'carb' => 9.3, 'fat' => 0.1],
            ['name' => 'Bơ lạt', 'aliases' => [], 'unit' => 'gram', 'protein' => 0.9, 'carb' => 0.1, 'fat' => 81],
            ['name' => 'Ốc hương', 'aliases' => [], 'unit' => 'gram', 'protein' => 16, 'carb' => 2, 'fat' => 1.5],
            ['name' => 'Sả', 'aliases' => [], 'unit' => 'gram', 'protein' => 1.8, 'carb' => 25, 'fat' => 0.5],
            ['name' => 'Rau răm', 'aliases' => [], 'unit' => 'gram', 'protein' => 3.6, 'carb' => 6.7, 'fat' => 0.4],
            ['name' => 'Pate', 'aliases' => [], 'unit' => 'gram', 'protein' => 13, 'carb' => 3, 'fat' => 28],
            ['name' => 'Xúc xích', 'aliases' => [], 'unit' => 'gram', 'protein' => 13, 'carb' => 2, 'fat' => 27],
            ['name' => 'Miến dong', 'aliases' => [], 'unit' => 'gram', 'protein' => 0.2, 'carb' => 86, 'fat' => 0.1],
            ['name' => 'Nấm hương', 'aliases' => [], 'unit' => 'gram', 'protein' => 2.2, 'carb' => 7.4, 'fat' => 0.5],
            ['name' => 'Bánh tráng', 'aliases' => [], 'unit' => 'gram', 'protein' => 0.3, 'carb' => 82, 'fat' => 0.2],
            ['name' => 'Bún', 'aliases' => [], 'unit' => 'gram', 'protein' => 1.8, 'carb' => 25, 'fat' => 0.2],
            ['name' => 'Rau thơm', 'aliases' => [], 'unit' => 'gram', 'protein' => 2, 'carb' => 5, 'fat' => 0.3],
            ['name' => 'Lạp xưởng', 'aliases' => [], 'unit' => 'gram', 'protein' => 14, 'carb' => 15, 'fat' => 27],
            ['name' => 'Đậu Hà Lan', 'aliases' => [], 'unit' => 'gram', 'protein' => 5.4, 'carb' => 14, 'fat' => 0.4],
            ['name' => 'Sợi bánh canh', 'aliases' => ['Bánh canh'], 'unit' => 'gram', 'protein' => 0.8, 'carb' => 30, 'fat' => 0.1],
            ['name' => 'Thịt cua', 'aliases' => [], 'unit' => 'gram', 'protein' => 19, 'carb' => 0, 'fat' => 1],
            ['name' => 'Xương ống', 'aliases' => [], 'unit' => 'gram', 'protein' => 10, 'carb' => 0, 'fat' => 15],
            ['name' => 'Chả cua', 'aliases' => [], 'unit' => 'gram', 'protein' => 12, 'carb' => 10, 'fat' => 6],
            ['name' => 'Riềng', 'aliases' => [], 'unit' => 'gram', 'protein' => 1, 'carb' => 6, 'fat' => 0.1],
            ['name' => 'Mẻ', 'aliases' => [], 'unit' => 'gram', 'protein' => 1.5, 'carb' => 15, 'fat' => 0.2],
            ['name' => 'Nghệ', 'aliases' => [], 'unit' => 'gram', 'protein' => 1.8, 'carb' => 10, 'fat' => 0.8],
            ['name' => 'Mắm tôm', 'aliases' => [], 'unit' => 'gram', 'protein' => 14, 'carb' => 6, 'fat' => 1],
            ['name' => 'Sữa chua Hy Lạp', 'aliases' => [], 'unit' => 'gram', 'protein' => 10, 'carb' => 4, 'fat' => 0.4],
            ['name' => 'Rau Xà lách', 'aliases' => ['Xà lách', 'Xà lách Romaine'], 'unit' => 'gram', 'protein' => 1.4, 'carb' => 2.9, 'fat' => 0.2],
            ['name' => 'Bột bánh xèo', 'aliases' => [], 'unit' => 'gram', 'protein' => 6, 'carb' => 75, 'fat' => 1.5],
            ['name' => 'Cốt dừa', 'aliases' => [], 'unit' => 'ml', 'protein' => 2, 'carb' => 6, 'fat' => 24],
            ['name' => 'Giá', 'aliases' => [], 'unit' => 'gram', 'protein' => 3, 'carb' => 6, 'fat' => 0.2],
        ];
    }

    private function mealCatalog(): array
    {
        return [
            [
                'name' => 'Cá ngừ kho dứa',
                'description' => 'Vị chua ngọt tự nhiên, đậm đà.',
                'preparation' => "1. Sơ chế cá, dứa.\n2. Áp chảo cá.\n3. Phi thơm hành tỏi, xếp cá và dứa vào kho lửa nhỏ 20-25 phút.",
                'diet_type' => 'Nhiều đạm',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['Cá', 'Kho', 'High-Protein', 'Ít tinh bột'],
                'allergens' => [['name' => 'Hải sản', 'aliases' => ['Cá']]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Cá ngừ', 'aliases' => ['Cá ngừ phi lê']], 'quantity' => 300, 'kcal_per_100g' => 130],
                    ['ingredient' => ['name' => 'Dứa', 'aliases' => []], 'quantity' => 150, 'kcal_per_100g' => 50],
                    ['ingredient' => ['name' => 'Hành tím', 'aliases' => []], 'quantity' => 20, 'kcal_per_100g' => 72],
                ],
            ],
            [
                'name' => 'Ức gà áp chảo rau củ',
                'description' => 'Mềm, no lâu, không ngán.',
                'preparation' => "1. Ướp gà, thái rau củ.\n2. Áp chảo gà mỗi mặt 3-4 phút.\n3. Xào nhanh rau củ 3-4 phút.",
                'diet_type' => 'Nhiều đạm',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['EatClean', 'ỨcGà', 'High-Protein', 'Chất xơ'],
                'allergens' => [],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Ức gà', 'aliases' => ['Ức gà chín']], 'quantity' => 120, 'kcal_per_100g' => 165],
                    ['ingredient' => ['name' => 'Bông cải xanh', 'aliases' => []], 'quantity' => 70, 'kcal_per_100g' => 34],
                    ['ingredient' => ['name' => 'Cà rốt', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 41],
                    ['ingredient' => ['name' => 'Dầu olive', 'aliases' => ['Dầu oliu']], 'quantity' => 10, 'kcal_per_100g' => 884],
                ],
            ],
            [
                'name' => 'Thịt ba chỉ kho trứng',
                'description' => 'Món mặn béo vừa, hợp cơm trắng.',
                'preparation' => "1. Luộc trứng, áp chảo thịt.\n2. Thắng đường màu cánh gián.\n3. Kho thịt trứng với nước dừa 30 phút.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['MónMặn', 'ThịtHeo', 'Truyền thống'],
                'allergens' => [['name' => 'Trứng', 'aliases' => []]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Ba chỉ heo', 'aliases' => ['Thịt ba chỉ lợn', 'Ba chỉ']], 'quantity' => 80, 'kcal_per_100g' => 518],
                    ['ingredient' => ['name' => 'Trứng', 'aliases' => ['Trứng gà']], 'quantity' => 25, 'kcal_per_100g' => 155],
                    ['ingredient' => ['name' => 'Nước dừa', 'aliases' => []], 'quantity' => 40, 'kcal_per_100g' => 19],
                ],
            ],
            [
                'name' => 'Cá hồi áp chảo cải bó xôi',
                'description' => 'Giàu Omega-3, thanh nhẹ.',
                'preparation' => "1. Sơ chế, rắc muối tiêu lên cá.\n2. Áp chảo cá mỗi mặt 3-4 phút.\n3. Xào nhanh cải bó xôi với tỏi.",
                'diet_type' => 'Giữ dáng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['CáHồi', 'Omega3', 'Axit béo tốt'],
                'allergens' => [['name' => 'Hải sản', 'aliases' => ['Cá']]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Cá hồi', 'aliases' => ['Cá hồi phi lê']], 'quantity' => 120, 'kcal_per_100g' => 208],
                    ['ingredient' => ['name' => 'Rau chân vịt', 'aliases' => ['Cải bó xôi']], 'quantity' => 100, 'kcal_per_100g' => 23],
                    ['ingredient' => ['name' => 'Dầu olive', 'aliases' => ['Dầu oliu']], 'quantity' => 10, 'kcal_per_100g' => 884],
                ],
            ],
            [
                'name' => 'Sữa chua trái cây hạt chia',
                'description' => 'Thanh mát, hỗ trợ tiêu hóa.',
                'preparation' => "1. Trộn sữa chua với hạt chia, đợi 10-15 phút cho hạt nở.\n2. Thêm trái cây và mật ong.",
                'diet_type' => 'Giữ dáng',
                'meal_type' => 'Bữa ăn nhẹ',
                'tags' => ['Snack', 'HạtChia', 'Chất xơ'],
                'allergens' => [['name' => 'Sản phẩm từ sữa', 'aliases' => ['Sữa']]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Sữa chua không đường', 'aliases' => []], 'quantity' => 150, 'kcal_per_100g' => 63],
                    ['ingredient' => ['name' => 'Hạt chia', 'aliases' => []], 'quantity' => 10, 'kcal_per_100g' => 486],
                    ['ingredient' => ['name' => 'Chuối', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 89],
                    ['ingredient' => ['name' => 'Mật ong', 'aliases' => []], 'quantity' => 10, 'kcal_per_100g' => 304],
                ],
            ],
            [
                'name' => 'Đậu phụ sốt cà chua',
                'description' => 'Món chay dễ ăn, vị chua ngọt.',
                'preparation' => "1. Cắt đậu, băm cà chua.\n2. Áp chảo săn đậu.\n3. Làm sốt cà chua, cho đậu vào đun 5 phút.",
                'diet_type' => 'Ăn chay',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['MónChay', 'ĐậuPhụ', 'Thuần chay'],
                'allergens' => [],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Đậu hũ', 'aliases' => ['Đậu phụ', 'Đậu phụ trắng']], 'quantity' => 150, 'kcal_per_100g' => 76],
                    ['ingredient' => ['name' => 'Cà chua', 'aliases' => ['Cà chua bi']], 'quantity' => 120, 'kcal_per_100g' => 18],
                    ['ingredient' => ['name' => 'Dầu olive', 'aliases' => ['Dầu oliu']], 'quantity' => 10, 'kcal_per_100g' => 884],
                ],
            ],
            [
                'name' => 'Thịt bò băm sốt đậu cà',
                'description' => 'Mềm, đậm đà cho gia đình.',
                'preparation' => "1. Phi thơm hành tỏi, xào chín thịt bò.\n2. Thêm cà chua xào mềm với nước.\n3. Cho đậu vào đun 4-5 phút.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['ThịtBò', 'DễLàm'],
                'allergens' => [],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Thịt bò', 'aliases' => ['Thăn bò', 'Thịt bò thăn']], 'quantity' => 90, 'kcal_per_100g' => 250],
                    ['ingredient' => ['name' => 'Đậu hũ', 'aliases' => ['Đậu phụ', 'Đậu phụ trắng']], 'quantity' => 100, 'kcal_per_100g' => 76],
                    ['ingredient' => ['name' => 'Cà chua', 'aliases' => ['Cà chua bi']], 'quantity' => 120, 'kcal_per_100g' => 18],
                ],
            ],
            [
                'name' => 'Salad ức gà bơ xốt chanh',
                'description' => 'Thanh nhẹ, béo tốt từ bơ.',
                'preparation' => "1. Luộc hoặc áp chảo gà, cắt lát.\n2. Sơ chế rau củ, bơ.\n3. Pha sốt chanh mật ong và trộn nhẹ tay.",
                'diet_type' => 'Giữ dáng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['Salad', 'Bơ', 'EatClean'],
                'allergens' => [],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Ức gà', 'aliases' => ['Ức gà chín']], 'quantity' => 100, 'kcal_per_100g' => 165],
                    ['ingredient' => ['name' => 'Bơ', 'aliases' => ['Bơ quả']], 'quantity' => 70, 'kcal_per_100g' => 160],
                    ['ingredient' => ['name' => 'Rau Xà lách', 'aliases' => ['Xà lách', 'Xà lách Romaine']], 'quantity' => 50, 'kcal_per_100g' => 15],
                    ['ingredient' => ['name' => 'Dưa leo', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 15],
                ],
            ],
            [
                'name' => 'Yến mạch chuối hạt chia',
                'description' => 'Nhanh gọn, giàu chất xơ.',
                'preparation' => "1. Trộn yến mạch, hạt chia với sữa vào hũ.\n2. Thêm chuối, đậy kín để tủ lạnh ít nhất 4 giờ.",
                'diet_type' => 'Giữ dáng',
                'meal_type' => 'Bữa sáng',
                'tags' => ['OvernightOats', 'Healthy', 'Chất xơ'],
                'allergens' => [
                    ['name' => 'Sản phẩm từ sữa', 'aliases' => ['Sữa']],
                    ['name' => 'Yến mạch', 'aliases' => []],
                ],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Yến mạch', 'aliases' => []], 'quantity' => 40, 'kcal_per_100g' => 389],
                    ['ingredient' => ['name' => 'Chuối', 'aliases' => []], 'quantity' => 80, 'kcal_per_100g' => 89],
                    ['ingredient' => ['name' => 'Sữa tươi', 'aliases' => ['Sữa tươi không đường']], 'quantity' => 180, 'kcal_per_100g' => 61],
                    ['ingredient' => ['name' => 'Hạt chia', 'aliases' => []], 'quantity' => 10, 'kcal_per_100g' => 486],
                ],
            ],
            [
                'name' => 'Bò áp chảo sốt tiêu đen',
                'description' => 'Mềm, giàu sắt, cân bằng.',
                'preparation' => "1. Ướp bò với muối tiêu.\n2. Áp chảo bò 2-3 phút mỗi mặt, rưới bơ tỏi.\n3. Làm sốt tiêu đen từ chảo cũ và xào măng tây.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['Steak', 'MăngTây', 'ThịtBò'],
                'allergens' => [['name' => 'Sản phẩm từ sữa', 'aliases' => ['Bơ sữa']]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Thịt bò', 'aliases' => ['Thăn bò', 'Thịt bò thăn']], 'quantity' => 150, 'kcal_per_100g' => 250],
                    ['ingredient' => ['name' => 'Măng tây', 'aliases' => []], 'quantity' => 120, 'kcal_per_100g' => 20],
                    ['ingredient' => ['name' => 'Bơ lạt', 'aliases' => []], 'quantity' => 10, 'kcal_per_100g' => 717],
                ],
            ],
            [
                'name' => 'Bánh xèo tôm thịt',
                'description' => 'Vàng giòn, nhân đầy đặn.',
                'preparation' => "1. Pha bột với cốt dừa.\n2. Xào sơ tôm thịt.\n3. Tráng bánh mỏng, cho nhân và giá vào đậy nắp 2-3 phút.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['BánhXèo', 'ĐặcSản', 'Truyền thống'],
                'allergens' => [
                    ['name' => 'Hải sản', 'aliases' => ['Tôm', 'Hải sản có vỏ']],
                    ['name' => 'Cốt dừa', 'aliases' => []],
                ],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Bột bánh xèo', 'aliases' => []], 'quantity' => 150, 'kcal_per_100g' => 350],
                    ['ingredient' => ['name' => 'Cốt dừa', 'aliases' => []], 'quantity' => 100, 'kcal_per_100g' => 230],
                    ['ingredient' => ['name' => 'Tôm', 'aliases' => ['Tôm tươi']], 'quantity' => 100, 'kcal_per_100g' => 99],
                    ['ingredient' => ['name' => 'Ba chỉ heo', 'aliases' => ['Thịt ba chỉ lợn', 'Ba chỉ']], 'quantity' => 100, 'kcal_per_100g' => 518],
                ],
            ],
            [
                'name' => 'Súp bí đỏ kem tươi',
                'description' => 'Vị ngọt béo, ấm áp.',
                'preparation' => "1. Xào bí và hành tây với bơ, đun mềm với nước dùng.\n2. Xay nhuyễn hỗn hợp.\n3. Thêm kem tươi đun nhỏ lửa.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn nhẹ',
                'tags' => ['Súp', 'BíĐỏ'],
                'allergens' => [['name' => 'Sản phẩm từ sữa', 'aliases' => ['Sữa', 'Kem']]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Bí đỏ', 'aliases' => []], 'quantity' => 300, 'kcal_per_100g' => 26],
                    ['ingredient' => ['name' => 'Whipping cream', 'aliases' => ['Kem tươi']], 'quantity' => 100, 'kcal_per_100g' => 340],
                    ['ingredient' => ['name' => 'Nước dùng gà', 'aliases' => []], 'quantity' => 250, 'kcal_per_100g' => 15],
                    ['ingredient' => ['name' => 'Hành tây', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 40],
                ],
            ],
            [
                'name' => 'Ốc hương xào bơ tỏi',
                'description' => 'Giòn ngọt, thơm lừng.',
                'preparation' => "1. Chần sơ ốc với gừng.\n2. Tan chảy bơ, phi thơm tỏi sả.\n3. Xào ốc lửa lớn đến khi sốt sánh, thêm rau răm.",
                'diet_type' => 'Cheat day',
                'meal_type' => 'Bữa ăn phụ',
                'tags' => ['HảiSản', 'BơTỏi'],
                'allergens' => [
                    ['name' => 'Hải sản', 'aliases' => ['Ốc', 'Hải sản có vỏ']],
                    ['name' => 'Sản phẩm từ sữa', 'aliases' => ['Bơ']],
                ],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Ốc hương', 'aliases' => []], 'quantity' => 300, 'kcal_per_100g' => 90],
                    ['ingredient' => ['name' => 'Bơ lạt', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 717],
                    ['ingredient' => ['name' => 'Tỏi', 'aliases' => []], 'quantity' => 20, 'kcal_per_100g' => 149],
                    ['ingredient' => ['name' => 'Sả', 'aliases' => []], 'quantity' => 10, 'kcal_per_100g' => 99],
                ],
            ],
            [
                'name' => 'Bánh mì chảo thập cẩm',
                'description' => 'No nê, tràn đầy năng lượng.',
                'preparation' => "1. Ướp bò, thái hành tây.\n2. Chiên trứng, xúc xích và xào bò.\n3. Xếp tất cả lên chảo hoặc đĩa, rưới sốt.",
                'diet_type' => 'Nhiều tinh bột',
                'meal_type' => 'Bữa sáng',
                'tags' => ['BánhMìChảo', 'Sáng'],
                'allergens' => [
                    ['name' => 'Trứng', 'aliases' => []],
                    ['name' => 'Gan', 'aliases' => ['Pate']],
                ],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Bánh mì', 'aliases' => ['Bánh mì Baguette']], 'quantity' => 60, 'kcal_per_100g' => 274],
                    ['ingredient' => ['name' => 'Thịt bò', 'aliases' => ['Thăn bò', 'Thịt bò thăn']], 'quantity' => 80, 'kcal_per_100g' => 250],
                    ['ingredient' => ['name' => 'Pate', 'aliases' => []], 'quantity' => 30, 'kcal_per_100g' => 300],
                    ['ingredient' => ['name' => 'Trứng', 'aliases' => ['Trứng gà']], 'quantity' => 50, 'kcal_per_100g' => 155],
                    ['ingredient' => ['name' => 'Xúc xích', 'aliases' => []], 'quantity' => 40, 'kcal_per_100g' => 301],
                ],
            ],
            [
                'name' => 'Mì trộn Hàn Quốc (Japchae)',
                'description' => 'Dai trong, cân bằng dinh dưỡng.',
                'preparation' => "1. Luộc miến, trộn dầu mè.\n2. Ướp bò, thái sợi rau củ.\n3. Xào riêng từng loại rồi trộn đều với sốt nước tương.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['Japchae', 'MónHàn'],
                'allergens' => [['name' => 'Mè', 'aliases' => ['Vừng']]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Miến dong', 'aliases' => []], 'quantity' => 150, 'kcal_per_100g' => 351],
                    ['ingredient' => ['name' => 'Thịt bò', 'aliases' => ['Thăn bò', 'Thịt bò thăn']], 'quantity' => 150, 'kcal_per_100g' => 250],
                    ['ingredient' => ['name' => 'Cà rốt', 'aliases' => []], 'quantity' => 100, 'kcal_per_100g' => 41],
                    ['ingredient' => ['name' => 'Rau chân vịt', 'aliases' => ['Cải bó xôi']], 'quantity' => 100, 'kcal_per_100g' => 23],
                    ['ingredient' => ['name' => 'Nấm hương', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 34],
                ],
            ],
            [
                'name' => 'Gỏi cuốn tôm thịt',
                'description' => 'Tươi mát, nhẹ bụng.',
                'preparation' => "1. Luộc chín tôm thịt, sơ chế rau bún.\n2. Pha sốt tương đậu phộng.\n3. Nhúng bánh tráng, xếp nhân và cuốn chặt.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['GỏiCuốn', 'Healthy'],
                'allergens' => [
                    ['name' => 'Hải sản', 'aliases' => ['Tôm', 'Hải sản có vỏ']],
                    ['name' => 'Đậu phộng', 'aliases' => []],
                ],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Bánh tráng', 'aliases' => []], 'quantity' => 80, 'kcal_per_100g' => 333],
                    ['ingredient' => ['name' => 'Tôm', 'aliases' => ['Tôm tươi']], 'quantity' => 100, 'kcal_per_100g' => 99],
                    ['ingredient' => ['name' => 'Ba chỉ heo', 'aliases' => ['Thịt ba chỉ lợn', 'Ba chỉ']], 'quantity' => 80, 'kcal_per_100g' => 518],
                    ['ingredient' => ['name' => 'Bún', 'aliases' => []], 'quantity' => 100, 'kcal_per_100g' => 110],
                ],
            ],
            [
                'name' => 'Cơm chiên dương châu',
                'description' => 'Nhanh gọn, biến tấu đa dạng.',
                'preparation' => "1. Sơ chế tôm, lạp xưởng, đánh trứng.\n2. Chiên tơi trứng.\n3. Chiên cơm tơi, cho các nguyên liệu vào xào cùng và nêm gia vị.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['CơmChiên', 'DươngChâu'],
                'allergens' => [
                    ['name' => 'Trứng', 'aliases' => []],
                    ['name' => 'Hải sản', 'aliases' => ['Tôm', 'Hải sản có vỏ']],
                ],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Cơm trắng', 'aliases' => ['Cơm nguội', 'Gạo']], 'quantity' => 300, 'kcal_per_100g' => 130],
                    ['ingredient' => ['name' => 'Trứng', 'aliases' => ['Trứng gà']], 'quantity' => 100, 'kcal_per_100g' => 155],
                    ['ingredient' => ['name' => 'Tôm', 'aliases' => ['Tôm tươi']], 'quantity' => 80, 'kcal_per_100g' => 99],
                    ['ingredient' => ['name' => 'Lạp xưởng', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 420],
                    ['ingredient' => ['name' => 'Đậu Hà Lan', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 81],
                ],
            ],
            [
                'name' => 'Bánh canh cua',
                'description' => 'Đậm đà, sánh sệt.',
                'preparation' => "1. Ninh xương ống 1-2 giờ lấy nước dùng.\n2. Trần bánh canh.\n3. Đun nóng nước dùng, cho bánh canh và thịt cua vào.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['BánhCanh', 'Cua'],
                'allergens' => [['name' => 'Hải sản', 'aliases' => ['Cua', 'Hải sản có vỏ']]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Sợi bánh canh', 'aliases' => ['Bánh canh']], 'quantity' => 200, 'kcal_per_100g' => 110],
                    ['ingredient' => ['name' => 'Thịt cua', 'aliases' => []], 'quantity' => 150, 'kcal_per_100g' => 97],
                    ['ingredient' => ['name' => 'Xương ống', 'aliases' => []], 'quantity' => 300, 'kcal_per_100g' => 200],
                    ['ingredient' => ['name' => 'Chả cua', 'aliases' => []], 'quantity' => 100, 'kcal_per_100g' => 150],
                ],
            ],
            [
                'name' => 'Lươn om riềng mẻ',
                'description' => 'Đặc sản sánh đặc, thơm nồng.',
                'preparation' => "1. Ướp lươn với riềng, mẻ, mắm tôm 15 phút.\n2. Xào săn lươn, thêm nước om nhỏ lửa đến khi sánh sệt.\n3. Thêm thì là, rau răm.",
                'diet_type' => 'Cân bằng dinh dưỡng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['Lươn', 'OmRiềngMẻ', 'Truyền thống'],
                'allergens' => [['name' => 'Mắm tôm', 'aliases' => []]],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Lươn đồng', 'aliases' => ['Lươn']], 'quantity' => 400, 'kcal_per_100g' => 285],
                    ['ingredient' => ['name' => 'Riềng', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 80],
                    ['ingredient' => ['name' => 'Mẻ', 'aliases' => []], 'quantity' => 100, 'kcal_per_100g' => 60],
                    ['ingredient' => ['name' => 'Bún', 'aliases' => []], 'quantity' => 200, 'kcal_per_100g' => 110],
                    ['ingredient' => ['name' => 'Mắm tôm', 'aliases' => []], 'quantity' => 15, 'kcal_per_100g' => 88],
                ],
            ],
            [
                'name' => 'Salad ức gà sữa chua',
                'description' => 'Ít dầu mỡ, thanh vị.',
                'preparation' => "1. Nướng gà 200°C trong 15-20 phút, để nguội xé sợi.\n2. Làm sốt sữa chua chanh mù tạt.\n3. Trộn rau củ, gà với sốt và rắc hạnh nhân.",
                'diet_type' => 'Giữ dáng',
                'meal_type' => 'Bữa ăn chính',
                'tags' => ['Salad', 'SữaChua', 'Giảm cân'],
                'allergens' => [
                    ['name' => 'Sản phẩm từ sữa', 'aliases' => ['Sữa']],
                    ['name' => 'Hạnh nhân', 'aliases' => []],
                ],
                'ingredients' => [
                    ['ingredient' => ['name' => 'Ức gà', 'aliases' => ['Ức gà chín']], 'quantity' => 150, 'kcal_per_100g' => 165],
                    ['ingredient' => ['name' => 'Sữa chua Hy Lạp', 'aliases' => []], 'quantity' => 100, 'kcal_per_100g' => 59],
                    ['ingredient' => ['name' => 'Rau Xà lách', 'aliases' => ['Xà lách Romaine', 'Xà lách']], 'quantity' => 100, 'kcal_per_100g' => 17],
                    ['ingredient' => ['name' => 'Dưa leo', 'aliases' => []], 'quantity' => 50, 'kcal_per_100g' => 15],
                    ['ingredient' => ['name' => 'Hạnh nhân', 'aliases' => []], 'quantity' => 20, 'kcal_per_100g' => 579],
                ],
            ],
        ];
    }

    private function ensureMeal(array $meal, int $dietTypeId, int $mealTypeId): int
    {
        $existing = DB::table('meals')->where('name', $meal['name'])->first();

        if ($existing) {
            return (int) $existing->id;
        }

        return (int) DB::table('meals')->insertGetId([
            'name' => $meal['name'],
            'diet_type_id' => $dietTypeId,
            'meal_type_id' => $mealTypeId,
            'preparation' => $meal['preparation'],
            'image_url' => null,
            'description' => $meal['description'],
            'created_at' => now(),
            'updated_at' => now(),
            'deleted_at' => null,
        ]);
    }

    private function ensureIngredient(array $ingredient): int
    {
        return $this->ensureNamedRecord('ingredients', $ingredient['name'], $ingredient['aliases'] ?? [], [
            'unit' => $ingredient['unit'] ?? 'gram',
            'protein' => $ingredient['protein'] ?? null,
            'carb' => $ingredient['carb'] ?? null,
            'fat' => $ingredient['fat'] ?? null,
        ]);
    }

    private function ensureNamedRecord(
        string $table,
        string $name,
        array $aliases = [],
        array $extra = []
    ): int {
        $record = DB::table($table)
            ->whereIn('name', array_values(array_unique(array_merge([$name], $aliases))))
            ->first();

        if ($record) {
            return (int) $record->id;
        }

        return (int) DB::table($table)->insertGetId(array_merge([
            'name' => $name,
            'created_at' => now(),
            'updated_at' => now(),
            'deleted_at' => null,
        ], $extra));
    }

    private function ensurePivot(string $table, array $attributes): void
    {
        $exists = DB::table($table)
            ->where($attributes)
            ->exists();

        if ($exists) {
            return;
        }

        DB::table($table)->insert(array_merge($attributes, [
            'created_at' => now(),
            'updated_at' => now(),
            'deleted_at' => null,
        ]));
    }
}
