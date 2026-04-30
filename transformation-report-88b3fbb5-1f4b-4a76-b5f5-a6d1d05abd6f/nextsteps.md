# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages that may not have surfaced as build errors.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that could indicate runtime issues, even if they are not hard errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to the intended cross-platform version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Check for Windows-Specific Dependencies

Even without build errors, some APIs or packages may have been silently carried over that only function on Windows. Search the codebase for usage of:

- `System.Web` namespaces (not available in cross-platform .NET)
- `HttpContext` usage outside of ASP.NET Core patterns
- Windows Registry access (`Microsoft.Win32.Registry`)
- Any `[assembly: ...]` attributes that were previously in `AssemblyInfo.cs` and may now conflict with auto-generated assembly info

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate regressions introduced during the transformation or pre-existing issues.

### 7. Review Configuration Files

Check that configuration has been properly migrated:

- Legacy `Web.config` or `App.config` settings should now reside in `appsettings.json`
- Connection strings, app settings, and environment-specific values should be verified in `appsettings.json` and `appsettings.{Environment}.json`
- Confirm that `Startup.cs` or the top-level `Program.cs` correctly registers all required services and middleware

### 8. Validate Static Files and Views

If this is a web project, confirm that:

- Static files (CSS, JS, images) are located under the `wwwroot` folder
- Razor views or pages render correctly
- Any Bundling/Minification configuration has been updated to the ASP.NET Core equivalent

### 9. Test on a Non-Windows Platform (if applicable)

Since the goal is cross-platform compatibility, consider running the application on Linux or macOS to confirm there are no hidden platform-specific dependencies:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Address any `PlatformNotSupportedException` or similar runtime errors that appear.

### 10. Review Publish Output

Perform a publish to verify the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required files, assemblies, and assets are present before deploying to the target environment.