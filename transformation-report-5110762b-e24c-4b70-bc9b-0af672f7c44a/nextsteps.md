# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors:

```bash
dotnet build --configuration Release
```

Review the build output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it targets `net8.0` or the appropriate cross-platform runtime.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the codebase for any use of APIs that were available in .NET Framework but have changed behavior in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in cross-platform .NET)
- `HttpContext` and related ASP.NET pipeline APIs
- Windows-specific APIs such as the registry, `System.Drawing` (GDI+), or COM interop
- Configuration APIs (`System.Configuration.ConfigurationManager` requires an additional NuGet package)

### 7. Review Static Files and wwwroot

If this is an ASP.NET Core web project, confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder and that the middleware is configured correctly in `Program.cs` or `Startup.cs`:

```csharp
app.UseStaticFiles();
```

### 8. Verify Database Connectivity

If the project uses Entity Framework or another data access layer, confirm that:

- The connection string in `appsettings.json` is correct
- The database provider package targets cross-platform .NET (e.g., `Microsoft.EntityFrameworkCore.SqlServer`)
- Any pending migrations are applied:

```bash
dotnet ef database update
```

### 9. Deployment

Once the above steps are validated, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy to the target environment according to your hosting setup (IIS, Kestrel, Linux service, etc.).