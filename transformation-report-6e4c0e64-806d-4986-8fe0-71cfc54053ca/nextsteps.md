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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's key workflows to confirm expected behavior.

### 5. Review Replaced or Removed APIs

Cross-platform .NET does not support certain Windows-specific or legacy .NET Framework APIs. Check the codebase for usage of the following and replace as needed:

- `System.Web` namespaces (replaced by `Microsoft.AspNetCore`)
- `HttpContext.Current` (use dependency-injected `IHttpContextAccessor` instead)
- `ConfigurationManager` (replace with `Microsoft.Extensions.Configuration`)
- `System.Drawing` on non-Windows platforms (consider using a cross-platform alternative such as `SkiaSharp` or `ImageSharp`)

### 6. Verify Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` and that the application reads configuration correctly at runtime using `IConfiguration`.

### 7. Check Static Files and Middleware

If this is an ASP.NET Core web project, verify that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Confirm that any legacy `Global.asax` logic has been moved to the appropriate middleware or startup configuration.

### 8. Execute Tests

If the solution contains a test project, run all tests to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 9. Publish the Application

Once the application has been validated locally, publish it to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files, including static assets and configuration files, are present before deploying to the target environment.