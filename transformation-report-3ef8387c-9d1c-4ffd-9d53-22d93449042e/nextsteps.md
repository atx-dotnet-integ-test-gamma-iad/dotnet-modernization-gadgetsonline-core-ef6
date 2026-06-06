# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Verify Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 2. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or missing packages.

### 3. Build the Solution

Perform a full build to confirm there are no warnings that could indicate runtime issues:

```bash
dotnet build --configuration Release
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application locally to verify it runs as expected on the new runtime:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and test core functionality, including:
- Page rendering and routing
- Database connectivity (if applicable)
- Authentication and authorization flows
- Any e-commerce workflows such as product listing, cart, and checkout

### 6. Check for Runtime Compatibility Issues

Even with a clean build, certain legacy patterns may cause runtime errors. Pay attention to:

- **`System.Web` dependencies**: Any remaining references to `System.Web` APIs that were shim-mapped during transformation may not behave identically at runtime.
- **HTTP pipeline behavior**: Middleware ordering in `Startup.cs` or `Program.cs` should be reviewed to ensure it matches the intended request pipeline.
- **Session and authentication**: Verify that session state and cookie-based authentication are configured correctly in the new middleware pipeline.
- **Static files**: Confirm that static assets (CSS, JS, images) are being served correctly from the `wwwroot` folder.

### 7. Review Configuration Files

Ensure that settings previously in `Web.config` have been correctly migrated to `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  }
}
```

Verify that environment-specific configuration (e.g., `appsettings.Development.json`) is in place.

### 8. Database Connectivity

If the project uses Entity Framework or ADO.NET, confirm the connection string is valid and the database is reachable:

```bash
dotnet ef database update
```

If not using EF migrations, manually verify that queries execute correctly against the target database.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present.

### 10. Deploy to Target Environment

Copy the published output to your target hosting environment (IIS, Linux server, Azure App Service, etc.) and verify the application starts and responds correctly in that environment. Confirm that environment variables or host-level configuration are set appropriately to match what was previously in `Web.config`.