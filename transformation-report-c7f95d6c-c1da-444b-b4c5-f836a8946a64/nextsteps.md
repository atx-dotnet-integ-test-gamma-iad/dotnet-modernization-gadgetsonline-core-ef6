# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

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

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to check for any runtime exceptions that would not have been caught at compile time.

### 5. Check for Removed or Changed APIs

Even with a clean build, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available on cross-platform .NET. Confirm all usages have been replaced with ASP.NET Core equivalents.
- **`HttpContext` and session handling**: Verify that session and request/response handling works as expected under ASP.NET Core.
- **Database connectivity**: If Entity Framework is used, confirm the correct EF Core provider is configured and that migrations are up to date by running:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

### 6. Execute Existing Tests

If a test project exists in the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and address the underlying issues before proceeding.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are served correctly and are located under the `wwwroot` directory.
- Check that connection strings have been migrated to `appsettings.json` and are being read correctly at runtime.

### 8. Test on Target Platform

If the goal is to run on a non-Windows operating system, deploy or run the application on the target OS (Linux or macOS) and repeat the local run and functional verification steps to catch any remaining platform-specific issues.