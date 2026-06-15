# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about missing packages, deprecated packages, or version conflicts that may need to be resolved manually.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

Address any warnings that appear, as some may indicate runtime issues even if the build succeeds.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently between .NET Framework and modern .NET. Review the following areas manually:

- **HTTP and networking**: `HttpClient` usage, `WebRequest`/`WebResponse` (the latter is obsolete in modern .NET).
- **Configuration**: `System.Configuration.ConfigurationManager` requires the `System.Configuration.ConfigurationManager` NuGet package on modern .NET.
- **Database access**: Ensure any Entity Framework usage has been migrated from EF 6 to EF Core, or that the appropriate compatibility package is referenced.
- **Globalization**: Some globalization behaviors differ. Check if `<InvariantGlobalization>` is set in the project file or `runtimeconfig.json`.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify runtime behavior:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences introduced by the migration rather than simple compilation issues.

### 6. Manual Smoke Testing

Run the application locally and exercise the primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Specifically verify:
- Application startup completes without exceptions.
- Database connectivity functions correctly.
- Any authentication or session management behaves as expected.
- Static files and views (if applicable) are served correctly.

### 7. Review `web.config` vs `appsettings.json`

If this is a web project, confirm that configuration values previously held in `web.config` have been correctly migrated to `appsettings.json` or environment variables, as `web.config` is not used for application configuration in modern .NET.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all expected files, static assets, and dependencies are present before deploying to the target environment.