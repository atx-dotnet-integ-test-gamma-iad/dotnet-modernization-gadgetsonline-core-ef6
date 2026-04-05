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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Ensure any references have been replaced with ASP.NET Core equivalents.
- **Windows-specific APIs**: Any calls to the Windows Registry, `System.Drawing` (GDI+), or COM interop may require additional packages or replacements.
- **Configuration**: Confirm that `web.config`-based configuration has been migrated to `appsettings.json` and the `IConfiguration` pattern.
- **Authentication/Authorization**: Verify that any `FormsAuthentication` or `MembershipProvider` usage has been replaced with ASP.NET Core Identity or cookie authentication middleware.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL printed in the console output and manually verify that core pages and features load correctly.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 7. Review Static Files and Middleware

If this is a web project, confirm the following in `Program.cs` or `Startup.cs`:

- `app.UseStaticFiles()` is present if the project serves static assets.
- `app.UseRouting()` and `app.UseEndpoints()` (or `app.MapControllers()`) are correctly configured.
- Any custom HTTP modules or HTTP handlers from the original project have been converted to ASP.NET Core middleware.

### 8. Database and Entity Framework

If the project uses Entity Framework, verify the following:

- The correct EF Core provider package is installed (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).
- Connection strings in `appsettings.json` are correct and accessible in the target environment.
- Run a test query or apply pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Deployment

Once all validation steps pass, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` folder to the target server and ensure the correct .NET runtime version is installed on that server. Confirm the hosting environment (IIS, Kestrel, etc.) is configured to serve the application correctly.