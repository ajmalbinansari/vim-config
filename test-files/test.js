// JavaScript Test File for LSP Verification

const greet = (name) => {
  return `Hello, ${name}!`;
};

function calculateSum(a, b) {
  return a + b;
}

const result = calculateSum(5, 10);
console.log(greet("World"));
greet("asdasd");

// Test: Hover over 'greet' and press 'K' - should show function info
// Test: Press 'gd' on 'greet' - should go to definition
// Test: Press ',rn' on 'greet' - should rename
