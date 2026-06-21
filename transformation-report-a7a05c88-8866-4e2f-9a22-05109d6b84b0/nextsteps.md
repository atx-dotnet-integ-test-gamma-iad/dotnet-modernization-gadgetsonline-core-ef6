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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net6.0` or `net7.0`, consider updating it, as those versions are out of support.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key features and confirm that core functionality behaves the same as it did in the legacy version.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate correctness:

```bash
dotnet test
```

Review any failing tests carefully. Failures may indicate behavioral differences introduced by the framework migration rather than pre-existing bugs.

### 6. Review Replaced or Removed APIs

Cross-platform .NET removes or replaces certain Windows-specific APIs that were available in .NET Framework. Manually review the codebase for usage of the following common problem areas:

- `System.Web` namespaces (these are not available in cross-platform .NET)
- `HttpContext` usage outside of the request pipeline
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Any P/Invoke calls targeting Windows-specific native libraries

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values that were previously held in `Web.config` or `App.config`. The `Web.config` transformation system is not used in cross-platform .NET, so any environment-specific settings must be migrated to the `appsettings.{Environment}.json` pattern.

### 8. Check Static Files and wwwroot

If `GadgetsOnline` is a web project, confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as this is the expected convention in ASP.NET Core.

### 9. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm that:

- The connection string in `appsettings.json` is correct for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all expected files are present before deploying to the target environment.