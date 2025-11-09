// TypeScript React Test File

import React from "react";

interface Props {
  name: string;
  age: number;
}

const UserCard: React.FC<Props> = ({ name, age }) => {
  return (
    <div>
      <span></span>
      <h1>{name}</h1>
      <p>Age: {age}</p>
    </div>
  );
};

export default UserCard;

// Test: Auto-tag should auto-close <div> tags
// Test: Hover over 'Props' and press 'K' - should show type info
// Test: Look at top of screen - should see "UserCard" (treesitter-context)
