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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression or a test that requires updating due to the migration.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns.
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`.
- Any Windows-specific APIs (e.g., registry access, certain cryptography APIs) that may not function on non-Windows platforms.

### 7. Validate Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are being served correctly by checking the presence of `app.UseStaticFiles()` in the application startup.

### 8. Test on Target Platforms

If cross-platform support is a goal, test the application on each intended operating system (e.g., Linux, macOS) to identify any platform-specific issues that may not surface on Windows.