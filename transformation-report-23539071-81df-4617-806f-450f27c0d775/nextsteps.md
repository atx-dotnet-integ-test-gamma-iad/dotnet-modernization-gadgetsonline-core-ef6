# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of the **GadgetsOnline** solution appears to have completed successfully — no build errors were detected in any of the projects.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Ensure there are no warnings about missing packages or incompatible target frameworks.

### 2. Build the Solution
Perform a full solution build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that may indicate deprecated APIs, nullable reference issues, or compatibility concerns that were not treated as errors but could cause runtime problems.

### 3. Run Unit Tests
If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and address any failures before proceeding.

### 4. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it is using:

```xml
<TargetFramework>net8.0</TargetFramework>
```

and that the appropriate meta-package (e.g., `Microsoft.AspNetCore.App`) is referenced correctly.

### 5. Check for Removed or Changed APIs
Review any usage of APIs that were available in .NET Framework but have changed or been removed in modern .NET. Common areas to check in an e-commerce style project include:

- `System.Web` references — these are not available in modern .NET and must be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage — confirm these reference `Microsoft.AspNetCore.Http` types.
- `Session` and `Authentication` middleware — confirm these are configured in `Program.cs` or `Startup.cs` using the ASP.NET Core middleware pipeline.

### 6. Review Configuration Files
- Confirm that `web.config` settings have been migrated to `appsettings.json`.
- Confirm that connection strings are present in `appsettings.json` and are being read via `IConfiguration`.
- Remove any `web.config` transform files that are no longer applicable.

### 7. Run the Application Locally
Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows (product browsing, cart, checkout, etc.) to confirm runtime behavior is correct.

### 8. Review Static Files and Bundling
If the project previously used `System.Web.Optimization` (BundleConfig), confirm that static file serving and bundling have been replaced with the ASP.NET Core static files middleware and a compatible alternative such as `WebOptimizer` or manual script/style references.

### 9. Database Connectivity
If the project uses Entity Framework, confirm the version in use:

- **Entity Framework Core** — confirm migrations are present and the database context is registered in the dependency injection container.
- Run `dotnet ef database update` if migrations need to be applied.

### 10. Deployment
Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the output directory contains all expected files before deploying to the target environment.