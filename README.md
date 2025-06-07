
# Glucose Metric Calculator

This full-stack Rails + React application calculates and displays glucose metrics from continuous glucose monitoring data. It is built to support health coaches by offering real-time insights into a member’s glucose activity over time.

---

## Features

- Calculates Average Glucose (mg/dL)
- Calculates Time Above Range (% > 180 mg/dL)
- Calculates Time Below Range (% < 70 mg/dL)
- Computes each metric for:
  - Last 7 Days
  - Current Month
- Compares each metric against the prior period (Week-to-Week, Month-to-Month)
- Exposes metrics via API
- Frontend React dashboard with dynamic period switching

---

## React Dashboard

Visit `http://localhost:3000` to view a dashboard showing glucose metrics for a test member.

- You can switch between:
  - **Last 7 Days**
  - **Current Month**
- All metrics update automatically via API.

---

## API Endpoints


The darshboard or Homepage (`/index`) will by default show the details for member with ID: 1
For details of other members, use `/api/members/:id/metrics` url

### Get Metrics for a Member

```http
GET /api/members/:id/metrics?period=last_7_days
GET /api/members/:id/metrics?period=month
```

**Example:**

```bash
curl 'http://localhost:3000/api/members/1/metrics?period=month'
```

Returns:

```json
{
  "average_glucose": 153.2,
  "time_above_range": 33.33,
  "time_below_range": 16.67,
  "average_glucose_change": -5.1,
  "time_above_range_change": 6.67,
  "time_below_range_change": -8.33
}
```

---

## Assumptions

- Metrics are dynamically calculated per `Member` using ActiveRecord queries.
- Glucose values are in `mg/dL`.
- `tested_at` is stored in local time; `tz_offset` is collected but not used in calculations.
- All "last 7 days" calculations include today and the 6 prior days.
- Change from previous period is `current - previous` (can be negative).
- Metrics are not stored permanently in the DB; they are calculated on the fly.
- The ID passed in the url is Member ID and it is dynamically fetched from the url to provide the right data

---

## Setup Instructions

1. **Install Ruby and dependencies:**

```bash
bundle install
```

2. **Install JavaScript dependencies:**

```bash
yarn install
```

3. **Build JS assets:**

```bash
yarn build
```

4. **Set up the database:**

```bash
bundle exec rails db:create db:setup
```

5. **Start the development server:**

```bash
bin/dev
```

Visit `http://localhost:3000` in your browser.

6. **Members and Glucose levels are added in sqlite3 database using rails console**

```rails console
member = Member.create(name: "Dhvani")
member.save
```

7.  **To add GlucoseLevels for a given member**

```
member = Member.find_by(name: "Dhvani")
member.glucose_levels.create(value: 100, tested_at: Time.current, tz_offset: "+02:00")
member.glucose_levels.create(value: 105, tested_at: 2.hours.ago, tz_offset: "+02:00")
```

---

## AI Prompt Summary

This project was implemented with assistance from ChatGPT. AI was used for:

- Building test cases using RSpec
- Debugging Build issue to start Ruby on  Rails
- Debugging routing errors. The routes initialized were not matching, and AI suggested changes in routes.rb file
- Commands to access and edit sqlite3 database for testing
- Fetching id from url windows function

---

## Improvements with More Time

- Persist computed metrics into a `metrics` table for historical review
- Add proper timezone support using `tz_offset`
- Allow login-based member switching on the frontend
- Add caching for repeated metric queries
- Write full integration tests for API + frontend

---

## Author

Dhvani Patel  
GitHub: [dhvani898](https://github.com/dhvani898)
