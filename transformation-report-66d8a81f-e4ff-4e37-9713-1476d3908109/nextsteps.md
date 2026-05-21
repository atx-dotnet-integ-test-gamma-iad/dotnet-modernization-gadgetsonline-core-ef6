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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage, which is not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` — ensure these are sourced from `Microsoft.AspNetCore.Http`
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`
- `System.Runtime.Remoting` or `System.AppDomain` members that are not supported

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running application and verify that core functionality behaves as expected, including any database connections, authentication flows, and page rendering.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review test results and address any failures before proceeding.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains the correct configuration values that were previously held in `Web.config` or `App.config`.
- Verify that static files such as CSS, JavaScript, and images are placed under the `wwwroot` directory if this is an ASP.NET Core web project.
- Check that connection strings have been correctly migrated to `appsettings.json`.

### 8. Verify Database Connectivity

If the project uses Entity Framework, confirm the correct version is referenced. For cross-platform .NET, this should be Entity Framework Core. Run any pending migrations if applicable:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Check Runtime Behavior on Target Platforms

If cross-platform support is a goal, test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues that would not appear at compile time.