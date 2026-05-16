# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net9.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the project is a web application, confirm it uses `net8.0-windows` or simply `net8.0` depending on whether platform-specific APIs are required.

### 4. Run Unit Tests

If the solution contains test projects, execute all tests to verify runtime behavior has not been affected by the migration:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new framework version.

### 5. Check for Removed or Changed APIs

Even without build errors, certain APIs behave differently or have been removed in modern .NET. Review the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they must be replaced with `Microsoft.AspNetCore` equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Ensure usages have been migrated to the ASP.NET Core equivalents.
- **`ConfigurationManager`**: Replace with `Microsoft.Extensions.Configuration` if still present.
- **`Global.asax`**: This should have been replaced by `Program.cs` and `Startup.cs` (or the minimal hosting model in `Program.cs`).

### 6. Verify Application Configuration

Check that configuration files have been properly migrated:

- `Web.config` settings should be moved to `appsettings.json`.
- Connection strings should be present under the `ConnectionStrings` section in `appsettings.json`.
- Confirm environment-specific configuration files (e.g., `appsettings.Development.json`) are in place if needed.

### 7. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and manually verify that core functionality, routing, authentication (if applicable), and data access are all working as expected.

### 8. Review Static Files and Middleware

Confirm that static file serving, routing middleware, and any custom middleware are correctly registered in `Program.cs` or `Startup.cs`. Middleware order is significant in ASP.NET Core and incorrect ordering can cause subtle runtime issues.

### 9. Validate Database Connectivity

If the application uses Entity Framework or direct ADO.NET, verify that:

- The connection string in `appsettings.json` is correct.
- Migrations (if using Entity Framework Core) are up to date by running:

```bash
dotnet ef database update
```

- Data is being read and written correctly through the application UI or API endpoints.

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files, assemblies, and static assets are present before deploying to the target environment.