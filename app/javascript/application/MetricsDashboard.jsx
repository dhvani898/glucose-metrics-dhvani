import React, { useEffect, useState } from "react";

const MetricsDashboard = ({ memberId }) => {
  const [metrics, setMetrics] = useState({});
  const [period, setPeriod] = useState("last_7_days");

  useEffect(() => {
    fetch(`/api/members/${memberId}/metrics?period=${period}`)
      .then((res) => res.json())
      .then((data) => setMetrics(data));
  }, [period, memberId]);

  return (
    <div>
      <h1>Glucose Metrics Dashboard</h1>

      <select value={period} onChange={(e) => setPeriod(e.target.value)}>
        <option value="last_7_days">Last 7 Days</option>
        <option value="month">This Month</option>
      </select>

      <table>
        <thead>
          <tr>
            <th>Metric</th>
            <th>Value</th>
            <th>Change</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Average Glucose</td>
            <td>{metrics.average_glucose}</td>
            <td>{metrics.average_glucose_change}</td>
          </tr>
          <tr>
            <td>Time Above Range</td>
            <td>{metrics.time_above_range}%</td>
            <td>{metrics.time_above_range_change}%</td>
          </tr>
          <tr>
            <td>Time Below Range</td>
            <td>{metrics.time_below_range}%</td>
            <td>{metrics.time_below_range_change}%</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
};

export default MetricsDashboard;