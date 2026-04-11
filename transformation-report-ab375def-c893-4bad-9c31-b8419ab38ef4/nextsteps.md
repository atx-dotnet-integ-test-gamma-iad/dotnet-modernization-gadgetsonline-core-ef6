# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution to cross-platform .NET appears to have completed successfully. No build errors were detected in any of the projects within the solution.

## Validation and Testing

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

### 2. Build the Solution
Perform a full solution build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Release
```

### 3. Run Unit Tests
If the solution contains any test projects, execute them to verify that existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release --verbosity normal
```

### 4. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to your intended .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating it to the current LTS release.

### 5. Review Removed or Changed APIs
Cross-platform .NET removes certain APIs that were available in .NET Framework. Verify the following areas manually:

- **System.Web**: Any references to `System.Web` (e.g., `HttpContext`, `HttpRequest`) should have been replaced with their `Microsoft.AspNetCore` equivalents.
- **Entity Framework**: Confirm that the project is using `Microsoft.EntityFrameworkCore` rather than the legacy `System.Data.Entity` namespace.
- **Configuration**: Ensure `System.Configuration.ConfigurationManager` usages have been replaced with `Microsoft.Extensions.Configuration`.
- **WCF or Remoting**: If the project used WCF or .NET Remoting, verify that appropriate replacements (e.g., `CoreWCF`) are in place.

### 6. Run the Application Locally
Start the application locally and navigate through its primary workflows to confirm runtime behavior is correct:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Check the application logs for any runtime exceptions or warnings that would not have appeared at build time.

### 7. Verify Static Files and Views
If this is an ASP.NET Core web project, manually verify that:

- Razor views (`.cshtml`) render correctly.
- Static assets (CSS, JavaScript, images) are served as expected.
- Any `bundleconfig.json` or asset pipeline configuration is functioning.

### 8. Database Migrations
If the project uses Entity Framework Core, confirm that existing migrations are compatible and that the database schema is correct:

```bash
dotnet ef migrations list
dotnet ef database update
```

### 9. Deployment
Once local validation is complete, publish the application to your target environment:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target server and ensure the correct .NET runtime version is installed on that server. You can verify the runtime availability with:

```bash
dotnet --list-runtimes
```