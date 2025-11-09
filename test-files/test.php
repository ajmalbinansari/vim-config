<?php

namespace App\Controller;

class UserController
{
    public function index(): array
    {
        return ['message' => 'Hello from PHP'];
    }

    public function show(int $id): ?array
    {
        return ['id' => $id];
    }
}

// Test: Hover over 'index' and press 'K' - should show Intelephense docs
// Test: Press 'gd' on 'UserController' - should go to class definition
// Test: Look at top - should see "UserController" (treesitter-context)
