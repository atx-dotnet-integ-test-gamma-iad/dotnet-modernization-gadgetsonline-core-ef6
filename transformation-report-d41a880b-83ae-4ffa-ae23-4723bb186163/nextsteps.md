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

Address any warnings that appear, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to the latest Long-Term Support (LTS) release.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality such as product listings, cart operations, and any authentication flows behave correctly.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to confirm no regressions were introduced during the transformation:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by transformation changes or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review any usages of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages, which have updated APIs in ASP.NET Core.
- Any usage of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- Windows-specific APIs such as the registry or certain `System.Drawing` methods, which may require alternative packages on non-Windows platforms.

### 7. Validate Static Files and Views

If the project uses Razor views or serves static files, verify that:

- The `wwwroot` folder is present and contains the expected static assets.
- Razor views render correctly without layout or partial view errors.
- Bundling and minification configurations have been updated if the legacy project used `System.Web.Optimization`.

### 8. Review Configuration Files

Confirm that `appsettings.json` contains all necessary configuration values that were previously held in `Web.config` or `App.config`. Pay particular attention to:

- Database connection strings.
- Application-specific settings.
- Any environment-specific overrides using `appsettings.Development.json` or similar files.

### 9. Database Connectivity

If the application uses Entity Framework, verify the database connection is functional:

- Confirm the connection string in `appsettings.json` is correct.
- If using Entity Framework Core, ensure migrations are up to date by running:

```bash
dotnet ef database update
```

- If the project was migrated from Entity Framework 6, review any breaking API differences between EF6 and EF Core.

### 10. Deploy to Target Environment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to the target hosting environment and verify the application starts and functions correctly in that environment.