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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or later and that the appropriate web SDK is declared:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages, which have updated APIs in ASP.NET Core.
- Any Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (use `System.Drawing.Common` with caution on non-Windows platforms).

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application to verify that core functionality behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression or a test configuration issue related to the migration.

### 7. Review Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. Key areas to verify:

- Connection strings
- Application settings
- Authentication configuration
- Logging configuration

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection string in `appsettings.json` is correct and that the application can connect and perform queries successfully at runtime.

### 9. Static Files and wwwroot

If this is a web application, confirm that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder and are being served correctly.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.