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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported version of .NET, such as `net8.0`. For example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves correctly.

### 5. Execute Tests

If a test project exists within the solution, run all tests to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they are the result of the migration or pre-existing issues.

### 6. Review Removed or Replaced APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` types

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values that were previously in `web.config` or `app.config`. Confirm that connection strings, application settings, and environment-specific values have been migrated correctly.

### 8. Check Static Files and wwwroot

If this is a web application, verify that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder, as this is the expected convention for ASP.NET Core applications.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and confirm all required files are present before deploying to the target environment.