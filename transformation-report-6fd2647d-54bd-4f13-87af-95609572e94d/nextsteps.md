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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify basic runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality works as expected, including any database connections, authentication, and page rendering.

### 5. Review Replaced or Removed APIs

Check for any usages of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` dependencies, which are not available in .NET Core or later
- `HttpContext` and related types, which may behave differently
- Windows-specific APIs such as the registry or certain cryptography providers
- Entity Framework — confirm whether the project has migrated from EF 6 to EF Core, and if so, verify that queries and migrations function correctly

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect actual regressions or tests that need to be updated to reflect new API behavior.

### 7. Check Static Files and Configuration

For web projects, verify the following:

- `appsettings.json` contains the correct configuration values that were previously in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder
- Any connection strings have been correctly moved to `appsettings.json` or environment variables

### 8. Verify Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` (and `Startup.cs` if present) to confirm that:

- Middleware is registered in the correct order
- Services such as authentication, authorization, and database contexts are properly configured
- Any custom HTTP modules or handlers from the legacy project have been replaced with equivalent ASP.NET Core middleware

### 9. Test on Target Operating Systems

Since the goal of the transformation is cross-platform compatibility, run and test the application on each operating system you intend to support (Windows, Linux, macOS) to surface any platform-specific issues.

### 10. Deployment

Once all validation steps pass, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` folder and deploy them to your target environment according to your hosting setup (e.g., IIS, Kestrel behind a reverse proxy, or a Linux server).