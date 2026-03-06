# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is not what you intended, update it and re-run `dotnet build`.

### 4. Run Unit Tests

If the solution contains any test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework runtime and the modern .NET runtime.

### 5. Verify Runtime Behavior

Launch the application and manually exercise the core workflows, particularly any areas that relied on:

- `System.Web` APIs (replaced by `Microsoft.AspNetCore`)
- Windows-specific APIs (e.g., registry access, COM interop)
- `HttpContext`, session state, or authentication middleware
- Entity Framework (confirm whether EF6 or EF Core is now being used and that migrations are intact)

### 6. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tool to surface any API usage that may compile but behave differently at runtime:

```bash
dotnet tool install -g dotnet-apicompat
```

### 7. Review `web.config` vs `appsettings.json`

If this is a web project, confirm that configuration values previously stored in `web.config` have been migrated to `appsettings.json` and are being read correctly through `IConfiguration`.

### 8. Static Files and wwwroot

Verify that static assets (CSS, JavaScript, images) are placed under the `wwwroot` folder and are being served correctly by the ASP.NET Core static files middleware.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present before deploying to the target environment.