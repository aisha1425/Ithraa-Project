<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Accomindation>
 */
class AccomindationFactory extends Factory
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
            'location' => Str::random(10),
            'type' => Str::random(10),
            'distance' => 'العقيق',
            'price' => rand(10, 1000),
            'kitchen' => 'Available',
            'laundary' => 'Available',
            'parking' => 'Available',
            'internet' => 'Available',
            'bedrooms' => rand(0 , 10),
            'bathrooms' => rand(0 , 3),
            'call' => Str::random(10),
            'userEmail' => 'business@gmail.com',
        ];
    }
}
