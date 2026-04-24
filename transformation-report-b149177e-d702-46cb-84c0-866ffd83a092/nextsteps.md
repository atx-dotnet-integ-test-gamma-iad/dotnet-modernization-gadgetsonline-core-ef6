# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to deprecated APIs or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in the .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage, which should now come from `Microsoft.AspNetCore.Http`
- Any Windows-specific APIs such as the registry, WMI, or COM interop

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package to identify remaining compatibility issues.

### 5. Run the Application Locally

Start the application locally and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows and confirm that core functionality behaves as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to verify that existing behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences in cross-platform .NET or by changes introduced during transformation.

### 7. Review Configuration Files

Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings
- Authentication configuration

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection string is correct and that the application can connect and perform queries successfully at runtime.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Deploy to Target Environment

Copy the published output to the target hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify this with:

```bash
dotnet --info
```

If hosting on IIS, confirm that the ASP.NET Core Hosting Bundle is installed and that the application pool is configured to use **No Managed Code**.