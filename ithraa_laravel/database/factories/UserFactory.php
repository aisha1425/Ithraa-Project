<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'username' => fake()->name(),
            'email' => fake()->unique()->safeEmail(),
            'phone' => Str::random(10),
            'businessType' => 'Accomindation Agent',
            'image' => '',
            'major' => Str::random(10),
            'universityLocation' => Str::random(10),
            'date' => Str::random(10),
            'type' => 'Student',
            'regNumber' => Str::random(10),
            'location' => Str::random(10),
            'contact' => Str::random(10),
            'website' => Str::random(10),
            'regFile' => Str::random(10),
            'status' => 0,
            'password' => Str::random(6),
            'email_verified_at' => now(),
            'remember_token' => Str::random(10),
        ];
    }

    /**
     * Indicate that the model's email address should be unverified.
     */
    public function unverified(): static
    {
        return $this->state(fn (array $attributes) => [
            'email_verified_at' => null,
        ]);
    }
}
