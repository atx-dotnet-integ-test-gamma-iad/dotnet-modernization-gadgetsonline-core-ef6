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

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. Avoid using `net5.0` or `net6.0` as these are out of support.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Check for Windows-Specific Dependencies

Since this is a cross-platform migration, review the project for any remaining Windows-specific APIs or libraries. Common areas to check include:

- `System.Web` references, which are not available on cross-platform .NET
- Windows Registry access via `Microsoft.Win32`
- Any P/Invoke calls targeting Windows-only system libraries

If the application is an ASP.NET Web Forms or MVC project originally built on `System.Web`, confirm it has been migrated to ASP.NET Core equivalents.

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not changed:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as failures may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 6. Verify Application Startup

Run the application locally and confirm it starts without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the core functionality of the application to check for runtime errors that would not surface at build time, such as missing configuration values, changed middleware behavior, or missing static assets.

### 7. Review Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. The `System.Configuration.ConfigurationManager` approach is replaced by `Microsoft.Extensions.Configuration` in cross-platform .NET.

### 8. Static Files and wwwroot

If this is a web application, confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as ASP.NET Core serves static files from this directory by default.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, including configuration files and static assets, are present before deploying to the target environment.