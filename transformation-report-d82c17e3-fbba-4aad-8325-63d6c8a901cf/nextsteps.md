# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support lifecycle](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to check for any runtime errors that would not have been caught at compile time.

### 5. Check for Runtime Compatibility Issues

Even with a clean build, certain areas are prone to runtime issues after a cross-platform migration. Manually verify the following:

- **File paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\` or backslashes) exist in configuration files or code. Use `Path.Combine` or forward slashes where applicable.
- **Database connections**: Confirm connection strings in `appsettings.json` or `web.config` are valid and accessible from the new runtime environment.
- **Authentication and session handling**: If the project uses ASP.NET Identity or cookie-based auth, verify that middleware is configured correctly in `Program.cs` or `Startup.cs`.
- **Static files**: Confirm that static assets (CSS, JS, images) are being served correctly and that paths are case-sensitive where the deployment OS requires it (e.g., Linux).

### 6. Execute Existing Tests

If the solution contains a test project, run all tests to validate core logic:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

### 7. Review Removed or Replaced APIs

Check the codebase for any use of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas include:

- `System.Web` namespace usage (should be replaced with `Microsoft.AspNetCore` equivalents)
- `HttpContext.Current` (not available in ASP.NET Core; use dependency injection instead)
- `ConfigurationManager` (replaced by `IConfiguration` in ASP.NET Core)
- `Global.asax` lifecycle events (replaced by middleware in `Program.cs`)

### 8. Review NuGet Package Compatibility

Run the following command to check for outdated or vulnerable packages:

```bash
dotnet list package --outdated
dotnet list package --vulnerable
```

Update packages where appropriate, particularly any that were carried over from the legacy project and may have newer cross-platform compatible versions.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, configuration, and assets are present before deploying to the target environment.