# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution
Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run Unit Tests
If the solution contains any test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime.

### 5. Verify Runtime Behavior
Launch the application locally and manually exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and any Entity Framework migrations
- Authentication and session management, as middleware configuration changed significantly between legacy ASP.NET and modern ASP.NET Core
- Static file serving and routing behavior
- Any third-party integrations or HTTP client usage

### 6. Check for Removed or Changed APIs
Review the code for usage of APIs that were removed or significantly altered in the move to cross-platform .NET. Common areas to inspect include:

- `System.Web` references — these are not available in .NET Core and any remaining usage must be replaced with ASP.NET Core equivalents
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- Configuration access patterns (`ConfigurationManager` vs `IConfiguration`)
- Any Windows-specific APIs (registry access, WCF, etc.) if cross-platform support is required

### 7. Review Application Configuration
Confirm that `appsettings.json` contains all necessary configuration values that were previously stored in `Web.config` or `App.config`. Verify connection strings, application settings, and environment-specific values are correctly migrated.

### 8. Publish the Application
Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to the target environment.