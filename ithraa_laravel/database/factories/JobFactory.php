<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Job>
 */
class JobFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'title' => Str::random(10),
            'description' => Str::random(10),
            'location' => Str::random(10),
            'type' => Str::random(10),
            'salary' => rand(10, 1000),
            'deadline' => Str::random(10),
            'userEmail' => 'business@gmail.com',
        ];
    }
}
