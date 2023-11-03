# dashboard (prototype)

In addition to it's primary purpose of producing easily modifiable dashboards,
this prototype framework was also meant to explore the following areas:

- using Go for desktop application development;
- DSL ergonomics for writing custom dashboards.

**This software has a fatal flaw which will never be fixed. Take a look at
knobs (the successor to this prototype) instead.** The flaw is that a dashboard
produced with this framework may panic unpredictably when handling signals,
due to the fact that signals and cgo (which the gtk3 bindings need) cannot be
used together safely (think: signals received during collector pauses).
