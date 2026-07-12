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

Navigate through the application's key workflows to confirm core functionality is intact.

### 5. Review Replaced or Removed APIs

Cross-platform .NET transformations from legacy .NET Framework projects commonly involve replacements for the following areas. Manually verify each applies correctly in your project:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm all usages have been replaced with ASP.NET Core equivalents (e.g., `HttpContext`, middleware, etc.).
- **`ConfigurationManager`**: Should be replaced with `Microsoft.Extensions.Configuration`.
- **`HttpContext.Current`**: Should be replaced with injected `IHttpContextAccessor`.
- **Session and Authentication**: Confirm session and authentication middleware is correctly configured in `Program.cs` or `Startup.cs`.

### 6. Run Existing Tests

If the solution contains a test project, execute the tests to validate business logic has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and address them before proceeding.

### 7. Check Static Files and Views

If the project is a web application, verify that static files (CSS, JS, images) are being served correctly and that all Razor views render without errors. Pay particular attention to:

- Layout files (`_Layout.cshtml`)
- Partial views
- Tag Helpers that may have replaced legacy HTML Helpers

### 8. Review Logging and Error Handling

Confirm that logging is configured using `Microsoft.Extensions.Logging` and that any legacy `log4net` or `System.Diagnostics` logging has been properly migrated or replaced.

### 9. Database Connectivity

If the project uses Entity Framework, confirm the version being used:

- **Entity Framework Core** is the cross-platform equivalent of EF6.
- Run any pending migrations:

```bash
dotnet ef database update
```

Verify that connection strings in `appsettings.json` are correct for the target environment.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.