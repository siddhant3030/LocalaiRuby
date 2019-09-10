1. Backend Task

Task Statement:
XRides, delivers about a 200 rides per minute or 288,000 rides per day. Now, they want to send this data to your system via an API. Your task is to create this API and save the data into PostgreSQL. The API should be designed, keeping in mind the real-time streaming nature of data and the burst of requests at peak times of the day. The user of this API expects an acknowledgment that the data is accepted and a way to track if the request fails.
Brownie Points:

Write a query DSL of how you would want this data to be queried and how someone would be able to run analytics operations on top of it.
Write up on the ideal system architecture and the design of API given enough time and resources.

2. Implementation:

It is not unusual to think about scalability as an easy thing to achieve. Hosting services such as Heroku are able to provide more resources to our applications, such as RAM or CPU. In order to do any optimization on your application you will need to measure and measure again! Metrics are the most important and useful weapon in your arsenal when optimizing. 

I use tools and technologies which are easy to learn and integrate. So delayed_job with ActiveJob has been my first choice for any MVP being built at StackAvenue for all background processing. Our riqurements are traction in the MVP, I want us to build the enterprise solution and scale it. By nature, delayed_job doesn’t scale well for large number of jobs because of following limitations:

1. Stores jobs in a database table, it slows down your application if there is a huge backlog of pending/failed jobs.
2. Spin off processes instead of thread for each job.

To overcome this limitation in terms of scalability, we have a few choices like Sidekiq, Resque, Sucker Punch etc. for background processing and Sidekiq has always been my choice for following reasons:

1. Stores jobs in Redis (in-memory database) which is inherently faster over other databases.
2. Spin off very lightweight workers for each job to conserve resources.
3. Provides Web UI to monitor the job processing.

Another Solution:-

When making requests to an external service’s API, some requests will frequently occur with the same parameters and return the same result. If we cache our request or response, we can reduce HTTP requests, which can improve performance and avoid hitting rate limits. The APICache Ruby gem is a good choice for caching the API responses (typically JSON) in any Moneta store, such as Memcache or Redis. However, we don’t always need to cache the entire API response. We can save space, avoid adding the operational overhead of Memcache or Redis, and avoid repeating the JSON parsing step if we cache only the URL requested.



I would use Graphql for the queries to improve the performance. I'll tell you why but the first question is

What is GraphQL?

A GraphQL query is a string that is sent to a server to be interpreted and fulfilled, which then returns JSON back to the client.

Defines a data shape: The first thing you’ll notice is that GraphQL queries mirror their response. This makes it easy to predict the shape of the data returned from a query, as well as to write a query if you know the data your app needs. More important, this makes GraphQL really easy to learn and use. GraphQL is unapologetically driven by the data requirements of products and of the designers and developers who build them.

Hierarchical: Another important aspect of GraphQL is its hierarchical nature. GraphQL naturally follows relationships between objects, where a RESTful service may require multiple round-trips (resource-intensive on mobile networks) or a complex join statement in SQL. This data hierarchy pairs well with graph-structured data stores and ultimately with the hierarchical user interfaces it’s used within.

Strongly typed: Each level of a GraphQL query corresponds to a particular type, and each type describes a set of available fields. Similar to SQL, this allows GraphQL to provide descriptive error messages before executing a query.

Protocol, not storage: Each GraphQL field on the server is backed by any arbitrary function. While we were building GraphQL to support News Feed, we already had a sophisticated feed ranking and storage model, along with existing databases and business logic. GraphQL had to leverage all this existing work to be useful, and so does not dictate or provide any backing storage. Instead, GraphQL takes advantage of your existing code.

Introspective: A GraphQL server can be queried for the types it supports. This creates a powerful platform for tools and client software to build atop this information like code generation in statically typed languages, our application framework, Relay, or IDEs like GraphiQL (pictured below). GraphiQL helps developers learn and explore an API quickly without grepping the codebase or wrangling with cURL.









