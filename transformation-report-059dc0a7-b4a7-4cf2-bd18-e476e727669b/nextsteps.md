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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate framework.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality and confirm that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may behave differently in ASP.NET Core
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Any Windows-specific APIs such as the registry or WMI

### 6. Verify Data Access Layer

If the project uses Entity Framework, confirm the version in use:

```bash
dotnet list package
```

Ensure it is using Entity Framework Core rather than the legacy Entity Framework 6, unless EF6 cross-platform support has been explicitly configured. Validate that database migrations run correctly:

```bash
dotnet ef database update
```

### 7. Execute Existing Tests

If a test project exists in the solution, run all tests to confirm expected behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or test code that itself requires updating for the new framework.

### 8. Check Static Assets and Configuration Files

For web projects, verify the following:

- `appsettings.json` contains the correct connection strings and configuration values previously held in `web.config`
- Static files such as CSS, JavaScript, and images are served correctly
- Any `web.config` transforms or `system.web` configuration sections have been properly migrated to ASP.NET Core middleware and configuration

### 9. Deployment Preparation

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.