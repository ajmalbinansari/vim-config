// TypeScript React Test File - Long function for treesitter-context testing

import React from "react";

interface Props {
  name: string;
  age: number;
  email: string;
  address: string;
}

const UserProfile: React.FC<Props> = ({ name, age, email, address }) => {
  // This is a long function to test treesitter-context
  const [isLoading, setIsLoading] = React.useState(false);
  const [data, setData] = React.useState(null);

  const handleClick = () => {
    console.log("Button clicked");
    setIsLoading(true);
  };

  const processData = () => {
    console.log("Processing data...");
    console.log("Step 1");
    console.log("Step 2");
    console.log("Step 3");
    console.log("Step 4");
    console.log("Step 5");
  };

  const validateEmail = (email: string) => {
    return email.includes("@");
  };

  return (
    <div className="user-profile">
      <header>
        <h1>{name}</h1>
        <p> Age: {age}</p>
      </header>

      <section className="details">
        <div className="email">
          <label>Email:</label>
          <span>{email}</span>
        </div>

        <div className="address">
          <label>Address:</label>
          <span>{address}</span>
        </div>
      </section>

      <section className="actions">
        <button onClick={handleClick}>Click Me</button>

        <button onClick={processData}>Process Data</button>
      </section>

      <footer>
        <p>User Profile Footer</p>
        <p>Additional information here</p>
        <p>More content</p>
        <p>Even more content</p>
        <p>Last line of the component</p>
      </footer>
    </div>
  );
};

export default UserProfile;

// TESTING INSTRUCTIONS:
// 1. Open this file: nvim test-files/test-long.tsx
// 2. Navigate to line 50 (inside the return statement): :50
// 3. NOW look at the very top of the window (above line numbers)
// 4. You should see a grayed/dimmed line showing:
//    "const UserProfile: React.FC<Props> = ({ name, age, email, address }) => {"
// 5. This is treesitter-context showing you're inside the UserProfile function
// 6. Scroll up and down - the context line appears/disappears as needed
