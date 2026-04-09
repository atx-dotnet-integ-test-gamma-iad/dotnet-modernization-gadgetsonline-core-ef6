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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Check for Removed or Replaced APIs

Even without build errors, some APIs that existed in the legacy .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET and may have been replaced with ASP.NET Core equivalents.
- Any usage of `HttpContext`, `HttpRequest`, or `HttpResponse` to confirm they reference the ASP.NET Core versions.
- Configuration access patterns, ensuring `System.Configuration.ConfigurationManager` has been replaced with `Microsoft.Extensions.Configuration`.
- Any file system paths that may have used Windows-specific formats.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm runtime behavior matches expectations from the legacy version.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review the test results and investigate any failures that may indicate behavioral differences introduced during the migration.

### 7. Review Static Files and wwwroot

If this is a web project, confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as required by ASP.NET Core's static file middleware.

### 8. Validate Database Connectivity

If the project uses Entity Framework or direct database access, confirm that:

- The connection string is being read from the new configuration system (e.g., `appsettings.json`).
- Any Entity Framework migrations are compatible with the target runtime.
- A test database operation (such as a read query) completes successfully at runtime.

### 9. Check Publish Output

Perform a publish to verify the output is complete and self-contained if needed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present.