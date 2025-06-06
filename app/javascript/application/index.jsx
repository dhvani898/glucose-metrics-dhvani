import React from 'react'
import ReactDOM from 'react-dom/client'
import MetricsDashboard from "./MetricsDashboard";

const rootElement = document.getElementById("root");

if (rootElement) {
  const root = ReactDOM.createRoot(rootElement);
  root.render(<MetricsDashboard memberId={1} />);
}

// const App = () => {
//   return (
//     <div>
//       <h1>Glucose Metrics Calculator</h1>
//     </div>
//   )
// }

// document.addEventListener('DOMContentLoaded', () => {
//   const root = ReactDOM.createRoot(document.getElementById('root'))
//   root.render(<App />)
// }) 