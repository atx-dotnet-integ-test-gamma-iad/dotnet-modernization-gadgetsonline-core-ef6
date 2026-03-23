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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version (e.g., `net5.0`, `net6.0`), consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior:

```bash
dotnet test --configuration Release
```

Review any failing tests and address them before proceeding to deployment.

### 5. Verify Runtime Behavior Manually

Run the application locally and exercise its core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Check for any runtime exceptions, missing configuration values, or broken functionality that would not surface at compile time.

### 6. Check Configuration Files

Review `appsettings.json` and any environment-specific configuration files (`appsettings.Development.json`, etc.) to ensure:

- Connection strings are valid and point to accessible data sources.
- Any API keys or external service endpoints are correctly configured.
- Logging levels are appropriate for the target environment.

### 7. Review Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Manually review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in cross-platform .NET).
- `HttpContext` usage outside of ASP.NET Core's dependency injection pattern.
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`).
- Windows Registry access or Windows-only APIs if cross-platform support is required.

### 8. Publish the Application

Once validation is complete, publish the application for the target environment:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target host.