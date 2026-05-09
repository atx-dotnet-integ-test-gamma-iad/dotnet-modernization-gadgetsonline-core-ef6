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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Review any warnings that appear. While warnings do not block the build, they may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET Support Policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported release.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to identify any runtime errors that would not surface at build time.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate correctness:

```bash
dotnet test
```

Review the test results and investigate any failures. If no tests currently exist, consider adding unit and integration tests to cover critical functionality before deployment.

### 6. Review Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework, particularly around:

- `System.Web` (e.g., `HttpContext`, `HttpRequest` in the legacy sense)
- Windows-specific APIs such as the registry or certain cryptography providers
- `AppDomain` and remoting APIs

Search the codebase for any usage of these APIs and verify they have been replaced with their .NET equivalents or suitable alternatives.

### 7. Verify Configuration System

.NET uses `appsettings.json` rather than `Web.config` or `App.config` by default. Confirm that:

- All configuration values previously in `Web.config` have been migrated to `appsettings.json`
- The application reads configuration using `IConfiguration` rather than `ConfigurationManager` where applicable

### 8. Check Static File and Middleware Configuration

If this is a web application, verify that middleware is correctly configured in `Program.cs` or `Startup.cs`, including:

- Static file serving
- Routing
- Authentication and authorization middleware
- Any custom HTTP modules or handlers that were migrated from the legacy project

### 9. Validate Database Connectivity

If the application uses a database, confirm that:

- Connection strings are correctly defined in `appsettings.json`
- Entity Framework Core (if used) migrations are up to date by running:

```bash
dotnet ef database update
```

- Data access functionality works correctly through manual or automated testing

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.