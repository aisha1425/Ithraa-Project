<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Transport>
 */
class TransportFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => Str::random(10),
            'description' => Str::random(10),
            'cost' => Str::random(10),
            'type' => Str::random(10),
            'distance' => 'العقيق',
            'availability' => Str::random(10),
            'userEmail' => 'business@gmail.com',
        ];
    }
}
