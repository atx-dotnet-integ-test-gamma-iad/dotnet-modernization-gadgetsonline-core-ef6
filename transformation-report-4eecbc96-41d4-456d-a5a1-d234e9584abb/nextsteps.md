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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a legacy `net48` or `netcoreapp` value).

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm behavior matches the legacy version.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in the .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` dependencies, which do not exist in cross-platform .NET
- `HttpContext` and related types, which may have different behavior in ASP.NET Core
- Configuration APIs (`ConfigurationManager` vs. `Microsoft.Extensions.Configuration`)
- Any Windows-specific APIs (registry access, WCF, etc.)

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 7. Review Static Files and Configuration

For web projects, confirm the following:

- `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder
- Middleware configuration in `Program.cs` or `Startup.cs` correctly replaces any legacy HTTP modules or handlers

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect successfully at runtime.

### 9. Check Publish Output

Perform a publish to verify the output is complete and well-formed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.