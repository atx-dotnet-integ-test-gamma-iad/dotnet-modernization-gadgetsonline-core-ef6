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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas of the code that may behave differently under modern .NET.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). Avoid using `net5.0` or `net6.0` as these are out of support.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally and verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test the primary user-facing features such as product browsing, cart functionality, and any checkout or account management flows.

### 5. Check for Runtime Errors

Even with a clean build, runtime issues can exist. Pay attention to:

- **Database connectivity**: Confirm connection strings in `appsettings.json` are correct and that the database provider (e.g., SQL Server, SQLite) is compatible with the target framework.
- **Authentication/Authorization**: If the project uses ASP.NET Identity or cookie-based auth, verify that middleware is configured correctly in `Program.cs` or `Startup.cs`.
- **Static files and routing**: Confirm that static file serving and route configurations behave as expected under the new runtime.

### 6. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Removed or Changed APIs

Cross-reference the codebase against the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [.NET API compatibility documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/) to identify any APIs that were available in the legacy framework but have changed behavior in modern .NET.

Areas to pay particular attention to in a project like `GadgetsOnline`:

- `System.Web` references (not available in modern .NET; should have been replaced with ASP.NET Core equivalents)
- `HttpContext` usage patterns
- Session and caching APIs
- Any use of `WebConfigurationManager` or `ConfigurationManager` (should be replaced with `IConfiguration`)

### 8. Validate Configuration Files

Ensure that `appsettings.json` contains all settings that were previously in `web.config` or `app.config`. The legacy configuration system is not supported in modern .NET.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, views, and static files are present.

### 10. Deploy to Target Environment

Copy the published output to the target hosting environment. Ensure the target server has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

The runtime version should match or be compatible with the `<TargetFramework>` specified in the project file.