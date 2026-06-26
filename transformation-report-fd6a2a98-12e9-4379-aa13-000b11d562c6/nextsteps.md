# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework needs to be updated, modify the value and re-run `dotnet restore` and `dotnet build`.

### 4. Run Unit Tests

If the solution contains test projects, execute all tests to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new framework version or by incomplete migration of specific components.

### 5. Verify Runtime Behavior

Run the application locally and manually exercise the core workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to the following areas that commonly require attention after a cross-platform migration:

- **File paths**: Ensure no hardcoded Windows-style paths (`\`) exist. Replace with `Path.Combine()` or forward slashes where appropriate.
- **Database connectivity**: Confirm connection strings and database providers are compatible with the new runtime.
- **Authentication and session management**: Verify middleware configuration in `Program.cs` or `Startup.cs` is correctly ordered and functional.
- **Static files and views**: Confirm all static assets load correctly and no references to removed or renamed packages exist (e.g., `System.Web` dependencies that may have been replaced).

### 6. Check for Removed or Replaced APIs

Search the codebase for any usage of APIs that are not available in cross-platform .NET, particularly anything previously sourced from `System.Web`. Common replacements include:

| Legacy API | Modern Equivalent |
|---|---|
| `HttpContext.Current` | `IHttpContextAccessor` |
| `System.Web.HttpRequest` | `Microsoft.AspNetCore.Http.HttpRequest` |
| `ConfigurationManager` | `IConfiguration` / `appsettings.json` |
| `Session` (classic) | `ISession` via ASP.NET Core middleware |

### 7. Review Application Configuration

Confirm that `appsettings.json` contains all necessary configuration values that were previously stored in `Web.config`. Verify that connection strings, application settings, and any environment-specific values have been correctly migrated.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assemblies, and static assets are present before deploying to the target environment.