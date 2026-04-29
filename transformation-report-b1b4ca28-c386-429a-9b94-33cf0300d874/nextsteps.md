# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while not blocking the build, may indicate compatibility concerns with the target framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it still references `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior matches expectations:

```bash
dotnet test --configuration Release
```

Address any failing tests before proceeding further.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET. Review the following areas manually:

- **File system paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) exist in the code.
- **Registry access**: `Microsoft.Win32.Registry` is not supported on Linux/macOS. Remove or conditionally compile any such usage.
- **`System.Web` dependencies**: If any `System.Web` types were referenced in the original project, confirm they have been replaced with appropriate ASP.NET Core equivalents.
- **Configuration**: Verify that `web.config`-based configuration has been replaced with `appsettings.json` and the `Microsoft.Extensions.Configuration` API.

### 6. Run the Application Locally

Start the application and exercise its primary functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows (e.g., product browsing, cart, checkout if applicable) and confirm they behave correctly.

### 7. Verify Database Connectivity

If the project uses Entity Framework or direct ADO.NET connections, confirm the connection strings in `appsettings.json` are valid and that the database provider package targets .NET (e.g., `Microsoft.EntityFrameworkCore.SqlServer` instead of the legacy EF6 package).

Run any pending migrations if applicable:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Review Static Files and Bundling

If the project previously used `System.Web.Optimization` (BundleConfig), confirm it has been replaced with a supported alternative such as `WebOptimizer` or a front-end build tool, and that static files are served correctly via the `UseStaticFiles()` middleware.

### 9. Check Authentication and Session Handling

If the application uses forms authentication or session state, confirm these have been migrated to ASP.NET Core's cookie authentication middleware and `ISession` respectively, and that they function correctly end-to-end.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all expected assets, views, and configuration files are present before deploying to the target environment.