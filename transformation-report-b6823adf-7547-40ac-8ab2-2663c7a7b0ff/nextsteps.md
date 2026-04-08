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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Ensure this aligns with the runtime environment where the application will be deployed.

### 4. Run the Application Locally

Start the application locally to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that functionality behaves as expected compared to the legacy version.

### 5. Review Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Check the following areas manually:

- **`System.Web` dependencies**: Any remaining references to `System.Web` (e.g., `HttpContext`, `HttpRequest`) should have been migrated to their `Microsoft.AspNetCore` equivalents.
- **`ConfigurationManager`**: If the project previously used `System.Configuration.ConfigurationManager`, confirm it has been replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: Confirm this has been replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model in `Program.cs` for .NET 6+).
- **`Web.config`**: Confirm that application settings have been migrated to `appsettings.json`.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences in the new framework or by incomplete migration of dependencies.

### 7. Check Static Files and Middleware

If `GadgetsOnline` is a web application, verify the following:

- Static files (CSS, JS, images) are being served correctly via `UseStaticFiles()` middleware.
- Authentication and session middleware are configured correctly in the request pipeline.
- Any custom HTTP handlers or modules from the legacy project have been converted to ASP.NET Core middleware.

### 8. Validate Database Connectivity

If the application uses Entity Framework or direct database access, confirm the following:

- The connection string in `appsettings.json` is correct.
- If migrating from Entity Framework 6 to Entity Framework Core, review any breaking changes in LINQ queries, lazy loading behavior, and migration commands.
- Run any pending database migrations:

```bash
dotnet ef database update
```

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and deploy it to the target environment, ensuring the correct .NET runtime is installed on the destination server.