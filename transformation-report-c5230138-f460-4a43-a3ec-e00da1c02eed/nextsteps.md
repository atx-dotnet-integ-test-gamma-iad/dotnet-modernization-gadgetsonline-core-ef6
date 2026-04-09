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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as it did in the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute the tests to confirm no regressions were introduced during transformation:

```bash
dotnet test
```

Review the test results and investigate any failures before proceeding.

### 6. Check for Removed or Replaced APIs

Cross-platform .NET does not support certain Windows-specific or legacy APIs that were available in .NET Framework. Manually review the codebase for usage of the following, which are commonly problematic after migration:

- `System.Web` namespaces (should be replaced with `Microsoft.AspNetCore` equivalents)
- `HttpContext` usage outside of ASP.NET Core middleware or controllers
- `ConfigurationManager` (should be replaced with `IConfiguration`)
- `System.Drawing` (may require the `System.Drawing.Common` NuGet package or an alternative library on non-Windows platforms)
- Windows Registry access (`Microsoft.Win32.Registry`)

### 7. Validate Configuration Files

Confirm that `appsettings.json` (or `appsettings.Development.json`) contains all configuration values that were previously stored in `Web.config` or `App.config`. The transformation process may not have migrated all configuration entries automatically.

### 8. Check Static Files and wwwroot

If this is a web project, verify that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder and are being served correctly when the application runs.

### 9. Review Middleware Pipeline

If this is an ASP.NET Core web project, open `Program.cs` or `Startup.cs` and confirm the middleware pipeline is configured correctly, including:

- Authentication and authorization middleware
- Static file middleware
- Routing middleware
- Any custom middleware that was present in the legacy project

### 10. Deployment

Once the above steps are completed and the application is validated:

1. Publish the application using the following command, replacing the runtime identifier as appropriate for your target environment:

```bash
dotnet publish --configuration Release --runtime win-x64 --self-contained false
```

2. Copy the contents of the `publish` output folder to your target server or hosting environment.
3. Confirm the hosting environment has the correct .NET runtime version installed, matching the `<TargetFramework>` in the project file.
4. Update any environment-specific configuration values in `appsettings.json` or through environment variables on the target machine.