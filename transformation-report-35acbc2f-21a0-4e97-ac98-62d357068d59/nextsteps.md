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

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas where the code relies on legacy behavior.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary features to confirm they function as expected after the migration.

### 5. Review Removed or Changed APIs

Check for usage of any APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns.
- Any use of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- Windows-specific APIs such as the registry or certain `System.Drawing` features.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to migration-related changes or pre-existing issues.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously held in `web.config` or `app.config`.
- Verify that static files such as CSS, JavaScript, and images are placed under the `wwwroot` folder and are being served correctly.

### 8. Check Database Connectivity

If the application uses a database, verify that the connection strings in `appsettings.json` are correct and that the application can connect and perform operations as expected. If Entity Framework is in use, confirm that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all expected files are present, then deploy the output to your target hosting environment.