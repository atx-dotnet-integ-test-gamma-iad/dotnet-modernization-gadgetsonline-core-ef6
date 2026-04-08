# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing or incompatible packages. If any packages are flagged as incompatible with the new target framework, check [NuGet.org](https://www.nuget.org) for updated versions.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the output shows zero errors and review any warnings, as some warnings may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Run Unit Tests

If the solution contains test projects, execute them to confirm existing functionality is preserved:

```bash
dotnet test
```

Review the test results and address any failing tests. Failing tests after a migration often indicate behavioral differences between the old .NET Framework APIs and their cross-platform .NET equivalents.

### 4. Check Runtime Behavior

Run the application locally and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to the following areas, which are common sources of runtime issues after migration:

- **Database connectivity**: Ensure connection strings are correctly configured and that the database provider (e.g., Entity Framework Core) is functioning as expected.
- **Authentication and authorization**: ASP.NET Core uses a different middleware pipeline than ASP.NET Framework. Verify that login, session, and role-based access behave correctly.
- **File system paths**: Cross-platform .NET is case-sensitive on Linux and macOS. Verify that any hardcoded file paths use the correct casing and path separators.
- **Configuration**: Confirm that `appsettings.json` (or equivalent) contains all necessary settings that were previously in `Web.config` or `App.config`.

### 5. Review Removed or Replaced APIs

Check the codebase for any usage of APIs that were available in .NET Framework but behave differently or have been replaced in cross-platform .NET:

- `System.Web` namespace usage should have been replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should reflect the ASP.NET Core versions.
- Any use of `ConfigurationManager` should be replaced with `IConfiguration`.

### 6. Verify Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your intended support and deployment environment.

### 7. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all expected files, static assets, and configuration files are present before deploying to the target environment.