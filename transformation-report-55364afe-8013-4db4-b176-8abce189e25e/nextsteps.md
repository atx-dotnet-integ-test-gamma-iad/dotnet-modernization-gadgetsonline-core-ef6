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

Address any warnings that appear, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure the chosen framework version is still within Microsoft's support window.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in the legacy .NET Framework but behave differently in cross-platform .NET, including:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have changed namespaces or behavior
- Windows-specific APIs such as the registry, WCF, or Windows Authentication, which may require additional packages or replacements

### 6. Execute Existing Tests

If the solution contains a test project, run all tests to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are caused by behavioral differences in the new framework or by issues introduced during transformation.

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`
- Verify that connection strings, application settings, and environment-specific values have been correctly migrated
- Check that static files, views, and other content files are included in the project and accessible at runtime

### 8. Test on Target Platforms

Since the project is now cross-platform, validate the application on each operating system you intend to support (Windows, Linux, macOS) to identify any platform-specific issues that may not surface on a single OS.

### 9. Review Deployment Output

Publish the application and inspect the output to confirm all required files are present:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory before deploying to any environment.