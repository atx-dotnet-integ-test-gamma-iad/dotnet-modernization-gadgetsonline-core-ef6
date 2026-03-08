# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-breaking, may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review test results carefully, paying attention to any tests that were previously passing under the legacy framework.

### 4. Review `web.config` and `appsettings.json`

ASP.NET Core uses `appsettings.json` instead of `web.config` for application configuration. Verify that:

- All connection strings from the legacy `web.config` have been moved to `appsettings.json`.
- Any custom `appSettings` keys have been migrated and are being read using `IConfiguration` rather than `ConfigurationManager`.
- Any `system.web` or IIS-specific settings have been reviewed and replaced with their ASP.NET Core equivalents where necessary.

### 5. Review Middleware and HTTP Pipeline

Confirm that the legacy `Global.asax`, `HttpModules`, and `HttpHandlers` have been replaced with the appropriate ASP.NET Core middleware registered in `Program.cs` or `Startup.cs`. Check that:

- Authentication and authorization middleware is correctly configured.
- Error handling middleware is in place.
- Static file serving is configured if the application serves static assets.

### 6. Verify Database Connectivity

If the project uses Entity Framework or direct database access, run the application locally and confirm:

- Migrations apply correctly (if using Entity Framework Core):

```bash
dotnet ef database update
```

- Queries execute without runtime exceptions related to provider compatibility.

### 7. Run the Application Locally

Start the application locally and perform manual smoke testing of the core user-facing functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the primary workflows of the application (e.g., product browsing, cart, checkout if applicable) and confirm expected behavior.

### 8. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest Long-Term Support (LTS) release.

## Deployment

### 1. Publish the Application

Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

### 2. Verify Published Output

Inspect the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and the compiled assemblies.

### 3. Configure the Hosting Environment

Ensure the target hosting environment (e.g., IIS, Kestrel behind a reverse proxy) is configured to host ASP.NET Core applications. For IIS specifically:

- Confirm the ASP.NET Core Hosting Bundle is installed on the server.
- Verify the IIS site is configured with the correct application pool set to **No Managed Code**.
- Confirm the `web.config` generated in the publish output contains the correct `aspNetCore` handler configuration.