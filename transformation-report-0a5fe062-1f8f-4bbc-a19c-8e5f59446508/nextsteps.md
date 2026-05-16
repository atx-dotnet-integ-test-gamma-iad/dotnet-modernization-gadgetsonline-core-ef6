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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **`System.Web` references**: These are not available in cross-platform .NET. If any remain, they will need to be replaced with ASP.NET Core equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Ensure these are using the `Microsoft.AspNetCore.Http` namespace rather than `System.Web`.
- **`ConfigurationManager`**: Replace with `Microsoft.Extensions.Configuration` if not already done.
- **`Session` and `Authentication`**: Confirm middleware is properly configured in `Program.cs` or `Startup.cs`.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the local URL provided in the output and verify that core functionality works as expected, including routing, page rendering, and any database interactions.

### 6. Verify Database Connectivity

If the project uses Entity Framework or direct database connections, confirm the connection strings in `appsettings.json` are correctly configured for the target environment and that migrations (if applicable) are up to date:

```bash
dotnet ef database update
```

### 7. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during the migration or pre-existing issues.

### 8. Review Publish Output

Perform a publish to verify the output is complete and self-contained if needed:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and binaries.