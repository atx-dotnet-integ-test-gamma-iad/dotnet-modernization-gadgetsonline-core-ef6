# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Ensure this aligns with your deployment environment.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, particularly any areas that relied on Windows-specific libraries in the legacy project (e.g., authentication, session management, data access).

### 5. Execute Unit Tests

If the solution contains test projects, run them to validate business logic and application behavior:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Verify Static Assets and Configuration

- Confirm that `wwwroot` contains all expected static assets (CSS, JavaScript, images).
- Review `appsettings.json` and `appsettings.Production.json` to ensure connection strings, API keys, and other configuration values have been correctly carried over from the legacy `Web.config`.
- If the legacy project used `Web.config` transforms, verify that equivalent environment-specific configuration is in place using the `appsettings.{Environment}.json` pattern.

### 7. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` and confirm the application can connect and perform queries as expected. If Entity Framework is in use, check that any pending migrations are applied:

```bash
dotnet ef database update
```

### 8. Review Middleware and HTTP Pipeline

If the original project used `Global.asax`, HTTP Modules, or HTTP Handlers, confirm that equivalent middleware has been registered in `Program.cs` or `Startup.cs`. Verify the order of middleware registration, as incorrect ordering can cause authentication, routing, or error-handling issues.

### 9. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required files are present, then deploy the contents to your target hosting environment (e.g., IIS, Azure App Service, or a Linux server with the ASP.NET Core runtime installed).

### 10. IIS Deployment Considerations (if applicable)

If deploying to IIS:

- Install the [.NET Hosting Bundle](https://dotnet.microsoft.com/en-us/download/dotnet) on the server.
- Configure the IIS Application Pool to use **No Managed Code**, as the ASP.NET Core module handles process management.
- Ensure the `web.config` generated in the publish output is present, as it configures the ASP.NET Core IIS module.